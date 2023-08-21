from flask import Flask, request, jsonify
import sqlite3
import os

app = Flask(__name__)
DB_FILE = "chat_database.db"

# Criação da tabela de mensagens caso não exista
def create_table():
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute('''CREATE TABLE IF NOT EXISTS messages 
                 (id INTEGER PRIMARY KEY AUTOINCREMENT,
                  mensagem VARCHAR(200),
                  data CHAR(20),
                  usuarioenv CHAR(11), 
                  usuariorec CHAR(11))''')
    c.execute('''CREATE TABLE IF NOT EXISTS listacontato 
                 (id INTEGER PRIMARY KEY AUTOINCREMENT, usuarioid CHAR(11),
                  nomeusuario CHAR(40), idcontato CHAR(11), nomecontato CHAR(40))''')
    c.execute('''CREATE TABLE IF NOT EXISTS usuario 
                 (id INTEGER PRIMARY KEY AUTOINCREMENT, usuarioid CHAR(11),
                  nome CHAR(40), senha CHAR(25))''')
    
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
    c.execute('''INSERT INTO usuario (usuarioid,nome,senha) 
                 VALUES (?,?,?)''', (usuarioid,nome,senha))
    
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
        # Salvar o usuário no banco de dados
        insert_usuario(usuarioid, nome, senha)

        return jsonify({'status': 'Usuário inserido com sucesso!'})

    else:
        # Obter todas os usuários do banco de dados
        usuario = get_usuarios()

        # Preparar a resposta em formato JSON
        resp_usuario = []
        for pessoa in usuario:
            usuario_dict = {
                'usuarioid': pessoa[0],
                'nome': pessoa[1],
                'senha': pessoa[2]
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
