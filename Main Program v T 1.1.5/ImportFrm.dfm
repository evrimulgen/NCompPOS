object ImportForm: TImportForm
  Left = 191
  Top = 109
  Caption = 'Import CSV Files'
  ClientHeight = 455
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object JvBitBtn1: TJvBitBtn
    Left = 688
    Top = 416
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkClose
    ParentDoubleBuffered = False
    TabOrder = 0
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
  end
  object JvDBGrid1: TJvDBGrid
    Left = 16
    Top = 16
    Width = 761
    Height = 393
    DataSource = ImportSource
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    MinColumnWidth = 200
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 17
  end
  object JvBitBtn2: TJvBitBtn
    Left = 560
    Top = 416
    Width = 97
    Height = 25
    Caption = 'Load Import File'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = JvBitBtn2Click
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
  end
  object JvBitBtn3: TJvBitBtn
    Left = 40
    Top = 416
    Width = 97
    Height = 25
    Caption = 'Import Stock RDP'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 3
    OnClick = JvBitBtn3Click
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
  end
  object ImportSource: TJvDataSource
    DataSet = Import
    Left = 448
    Top = 416
  end
  object Import: TJvCsvDataSet
    AutoBackupCount = 0
    Left = 416
    Top = 416
  end
  object JvOpenDialog1: TJvOpenDialog
    DefaultExt = 'csv'
    Filter = 'csv|*.csv|All|*.*'
    Height = 454
    Width = 563
    Left = 480
    Top = 416
  end
end
