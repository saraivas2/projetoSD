from flask import Flask, request, jsonify
import sqlite3
import bcrypt

app = Flask(__name__)
DB_FILE = "chat_database.db"

# Criar tabelas do bando de dados
def create_table():
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute('''CREATE TABLE IF NOT EXISTS messages 
                 (id INTEGER PRIMARY KEY AUTOINCREMENT,
                  mensagem TEXT,
                  data TEXT,
                  usuarioenv TEXT, 
                  usuariorec TEXT)''')
    c.execute('''CREATE TABLE IF NOT EXISTS listacontato 
                 (id INTEGER PRIMARY KEY AUTOINCREMENT, usuarioid TEXT,
                  nomeusuario TEXT, idcontato TEXT, nomecontato TEXT)''')
    c.execute('''CREATE TABLE IF NOT EXISTS usuario 
                 (id INTEGER PRIMARY KEY AUTOINCREMENT, usuarioid TEXT,
                  nome TEXT, senha TEXT)''')
    
    conn.commit()
    conn.close()

# Inserir uma nova mensagem no banco de dados
def insert_message(mensagem, data, usuarioenv, usuariorec):
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute('''INSERT INTO messages (mensagem, data, usuarioenv, usuariorec) 
                 VALUES (?,?,?,?)''', (mensagem, data, usuarioenv,usuariorec)) 
    conn.commit()
    conn.close()

# Inserir um novo usuário no banco de dados
def insert_usuario(usuarioid, nome,senha):
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    # Hash the password before storing it
    hashed_password = bcrypt.hashpw(senha.encode('utf-8'), bcrypt.gensalt())
    c.execute('''INSERT INTO usuario (usuarioid,nome,senha) 
                 VALUES (?,?,?)''', (usuarioid,nome,hashed_password))
    
    conn.commit()
    conn.close()

# Inserir um novo contato no banco de dados
def insert_contatousuario(usuarioid, nomeusuario, idcontato, nomecontato):
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute('''INSERT INTO listacontato (usuarioid, nomeusuario, idcontato, nomecontato) 
                 VALUES (?,?,?,?)''', (usuarioid,nomeusuario,idcontato,nomecontato))
    conn.commit()
    conn.close()

# Obter todas as mensagens do banco de dados
def get_messages(login, contato):
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute('''SELECT * FROM messages where (usuarioenv= ? and usuariorec = ?) 
              or (usuariorec= ? and usuarioenv = ?) order by id''',(login,contato,login,contato,))
    messages = c.fetchall()
    conn.close()
    return messages

# Validação da senha do usuário
def validate_passward(password, hash_password):
    retorno=bcrypt.checkpw(password, hash_password)
    return retorno


# Autenticação do usuário
@app.route('/autentico', methods=['POST'])
def authenticate_user():
    if request.method == 'POST':
        data = request.get_json()
        usuarioid = data['usuarioid']
        senha = data['senha']

        conn = sqlite3.connect(DB_FILE)
        c = conn.cursor()
        c.execute('SELECT senha FROM usuario WHERE usuarioid = ?', (usuarioid,))
        hash_senha = c.fetchone()

        if hash_senha is None:
            return jsonify({'error': False}), 401

        if validate_passward(senha.encode('utf-8'), hash_senha[0]):
            return jsonify({'message': True}), 200
        else:
            return jsonify({'error': False}), 401

# Obter todas os usuário do banco de dados
def get_usuarios():
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute('''SELECT * FROM usuario''')
    usuario = c.fetchall()
    conn.close()
    return usuario
# Obter todas os contatos do banco de dados
def get_contatos():
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute('''SELECT * FROM listacontato''')
    contatos = c.fetchall()
    conn.close()
    return contatos

@app.route('/')
def index():
    return "Bem-vindo ao Chat Ex: http://127.0.0.1:5000/."

@app.route('/chat', methods=['GET', 'POST'])
def chat_msm():
    if request.method == 'POST':
        data = request.get_json()
        mensagem = data['mensagem']
        data_mensagem = data['data']
        usuarioenv = data['usuarioenv']
        usuariorec = data['usuariorec']

        # Salvar a mensagem no banco de dados
        insert_message(mensagem, data_mensagem, usuarioenv, usuariorec)

        return jsonify({'status': 'Mensagem enviada com sucesso!'})

    else:
        try:
            login = request.args.get('login')
            contato = request.args.get('contato')

            if login is None or contato is None:
                return jsonify({'error': 'Parâmetros de login e contato são obrigatórios'})

            # Obter todas as mensagens do banco de dados
            messages = get_messages(login,contato)

            # Preparar a resposta em formato JSON
            response = []
            for msg in messages:
                message_dict = {
                    'id': msg[0],
                    'mensagem': msg[1],
                    'data': msg[2],
                    'usuarioenv': msg[3],
                    'usuariorec': msg[4]            
                }
                response.append(message_dict)

            return jsonify(response)
        except Exception as e:
            return jsonify({'error': str(e)})    
    
@app.route('/usuario', methods=['GET', 'POST'])
def usuario_cad():
    if request.method == 'POST':
        data = request.get_json()
        usuarioid = data['usuarioid']
        nome = data['nome']
        senha = data['senha']

        # Save the hashed password in the database
        insert_usuario(usuarioid, nome, senha)

        return jsonify({'status': 'Usuário inserido com sucesso!'})
    else:
       # Obter todas os usuários do banco de dados
        usuario = get_usuarios()

        # Preparar a resposta em formato JSON
        resp_usuario = []
        for pessoa in usuario:
            usuario_dict = {
                'id': pessoa[0],
                'usuarioid': pessoa[1],
                'nome': pessoa[2],
                
            }
            resp_usuario.append(usuario_dict)

        return jsonify(resp_usuario)

@app.route('/contato', methods=['GET', 'POST'])
def contatousuario_cad():
    if request.method == 'POST':
        data = request.get_json()
        usuarioid = data['usuarioid']
        nomeusuario = data['nomeusuario']
        idcontato = data['idcontato']
        nomecontato = data['nomecontato']
        # Salvar o contato no banco de dados
        insert_contatousuario(usuarioid, nomeusuario, idcontato, nomecontato)

        return jsonify({'status': 'Contato inserido com sucesso!'})

    else:
        # Obter todas os usuários do banco de dados
        contato= get_contatos()

        # Preparar a resposta em formato JSON
        resp_contatos = []
        for chave in contato:
            contato_dict = {
                'id': chave[0],
                'usuarioid': chave[1],
                'nomeusuario': chave[2],
                'idcontato': chave[3],
                'nomecontato': chave[4]
            }
            resp_contatos.append(contato_dict)

        return jsonify(resp_contatos)


if __name__ == '__main__':
    # Criação da tabela antes de executar o servidor
    create_table()

    # Execução do servidor na porta 5000
    app.run(debug=True)
