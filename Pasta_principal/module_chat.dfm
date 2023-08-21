object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 298
  Width = 681
  object RESTChat: TRESTClient
    BaseURL = 'http://localhost:5000'
    Params = <>
    Left = 48
    Top = 48
  end
  object RESTReqChat: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTChat
    Params = <>
    Resource = 'chat'
    Response = RESTRespChat
    Left = 152
    Top = 40
  end
  object RESTRespChat: TRESTResponse
    Left = 296
    Top = 48
  end
  object DataSetAdapterChat: TRESTResponseDataSetAdapter
    Dataset = MemTableChat
    FieldDefs = <>
    Response = RESTRespChat
    Left = 512
    Top = 40
  end
  object MemTableChat: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 392
    Top = 40
  end
  object RESTUsuario: TRESTClient
    BaseURL = 'http://localhost:5000'
    Params = <>
    Left = 48
    Top = 112
  end
  object RESTReqUsuario: TRESTRequest
    Client = RESTUsuario
    Params = <>
    Resource = 'usuario'
    Response = RESTRespUsuario
    Left = 152
    Top = 104
  end
  object RESTRespUsuario: TRESTResponse
    Left = 296
    Top = 112
  end
  object DataSetAdapterUsuario: TRESTResponseDataSetAdapter
    Dataset = MemTableUsuario
    FieldDefs = <>
    Response = RESTRespUsuario
    Left = 512
    Top = 104
  end
  object MemTableUsuario: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 392
    Top = 104
  end
  object RESTContatos: TRESTClient
    BaseURL = 'http://localhost:5000'
    Params = <>
    Left = 40
    Top = 192
  end
  object RESTReqContatos: TRESTRequest
    Client = RESTContatos
    Params = <>
    Resource = 'contato'
    Response = RESTRespContatos
    Left = 144
    Top = 184
  end
  object RESTRespContatos: TRESTResponse
    Left = 288
    Top = 192
  end
  object DataSetAdapterContatos: TRESTResponseDataSetAdapter
    Dataset = MemTableContatos
    FieldDefs = <>
    Response = RESTRespContatos
    Left = 504
    Top = 184
  end
  object MemTableContatos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 384
    Top = 184
  end
end
