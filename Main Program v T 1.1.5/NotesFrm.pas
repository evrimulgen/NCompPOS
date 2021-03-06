unit NotesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, Grids, DBGrids,
  UtilsUnit, JvExStdCtrls, JvEdit, JvExComCtrls, JvDateTimePicker, JvExDBGrids,
  JvDBGrid;

type
  TNotesForm = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    NoteDate: TJvDateTimePicker;
    UserDisplay: TLabel;
    FromWhere: TLabel;
    Reminder: TCheckBox;
    ReminderDate: TJvDateTimePicker;
    ReminderTime: TJvDateTimePicker;
    Cancel: TCheckBox;
    Description: TJvEdit;
    JvDBGrid1: TJvDBGrid;
    BitBtn1: TBitBtn;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ReminderClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DescriptionKeyPress(Sender: TObject; var Key: Char);
    procedure JvDBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
  private
    procedure NewNote;
    { Private declarations }
  public
    { Public declarations }
    DLinkStr, FromWhereStr: String;
    NrStr: Integer;
  end;

var
  NotesForm: TNotesForm;

implementation
    uses DataFrm2;

{$R *.dfm}

procedure TNotesForm.BitBtn1Click(Sender: TObject);
begin
          Close;
end;

procedure TNotesForm.Button1Click(Sender: TObject);
var
    AttentionDStr, AttentionTStr, s: String;
begin
    If Description.Text <> '' then
    begin
      If Button1.Caption = 'Add Note' then
      begin
        If Reminder.Checked = True then
        begin
          AttentionDStr := InttoStr(DatetoIntDate(ReminderDate.Date));
          AttentionTStr := TimetoStr(ReminderTime.Time);
        end
        else
        begin
          AttentionDStr := '0';
          AttentionTStr := '';
        end;
        s := '(' + InttoStr(DatetoIntDate(NoteDate.Date)) + ',' + DLinkStr + ',''' + FromWhereStr + ''',''' + FixSQLString(Description.Text) + ''',' + AttentionDStr + ',''' + UserDisplay.Caption + ''',''' + BooltoStr(Cancel.Checked) + ''',''' + AttentionTStr + ''')';
        DataForm2.Query1.Active := False;
        with DataForm2.Query1.SQL do begin
          Clear;
          Add('insert into notes_db(Date,LinkID,FromWhere,Description,AttentionDate,NoteBy,Completed,AttentionTime) values ');
          Add(s);
        end;
        DataForm2.Query1.ExecSQL;
        DataForm2.NotesQuery.Refresh;
      end
      else
      begin
        If Reminder.Checked = True then
        begin
          AttentionDStr := InttoStr(DatetoIntDate(ReminderDate.Date));
          AttentionTStr := TimetoStr(ReminderTime.Time);
        end
        else
        begin
          AttentionDStr := '0';
          AttentionTStr := '';
        end;
        DataForm2.Query1.Active := False;
        with DataForm2.Query1.SQL do begin
          Clear;
          Add('Update notes_db set Date = ' + InttoStr(DatetoIntDate(NoteDate.Date)) + ',Description = ''' + FixSQLString(Description.Text) + ''',AttentionDate = ' + AttentionDStr + ',Completed = ''' + BooltoStr(Cancel.Checked) + ''',AttentionTime = ''' + AttentionTStr + '''');
          Add('Where Nr = ' + Inttostr(NrStr))
        end;
        DataForm2.Query1.ExecSQL;
        DataForm2.NotesQuery.Refresh;
      end;
    end
    else
    begin
      showmessage('Type in Note First!');
    end;
end;

procedure TNotesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        Dataform2.NotesQuery.Close;
end;

procedure TNotesForm.FormShow(Sender: TObject);
begin
//        NewNote();
//        Description.SetFocus;
        Dataform2.NotesQuery.Close;
        with Dataform2.NotesQuery.SQL do
        begin
          Clear;
          Add('select * from notes_db');
          Add('order by `Date` Desc,Nr Desc'); 
        end;
        Dataform2.NotesQuery.Open;
end;

procedure TNotesForm.NewNote();
begin
        GroupBox1.Caption := 'Busy with New Note';
        Button1.Caption := 'Add Note';
        NoteDate.Date := date;
        UserDisplay.Caption := DataForm2.User_db.Fieldbyname('UserName').AsString;
        FromWhere.Caption := FromWhereStr;
        Description.Text := '';
        Reminder.Checked := False;
        ReminderDate.Date := date;
        ReminderDate.Enabled := False;
        ReminderTime.Time := time;
        ReminderTime.Enabled := False;
        Cancel.Checked := False;
        Cancel.Enabled := False;
end;

procedure TNotesForm.ReminderClick(Sender: TObject);
begin
        If Reminder.Checked = True then
        begin
          ReminderDate.Enabled := True;
          ReminderTime.Enabled := True;
          Cancel.Enabled := True;
        end
        else
        begin
          ReminderDate.Enabled := False;
          ReminderTime.Enabled := False;
          Cancel.Enabled := False;
        end;
end;

procedure TNotesForm.Button2Click(Sender: TObject);
begin
        NewNote();
end;

procedure TNotesForm.DescriptionKeyPress(Sender: TObject; var Key: Char);
begin
      if Key = #13 then
        Button1.Click;
end;

procedure TNotesForm.JvDBGrid1DblClick(Sender: TObject);
begin
{    if DataForm2.User_db.FieldByName('Rights').asInteger > 3 then
    begin
        GroupBox1.Caption := 'Busy to Edit a Note';
        Button1.Caption := 'Save Note';
        NoteDate.Date := date;
        UserDisplay.Caption := DataForm2.NotesQuery.Fieldbyname('NoteBy').AsString;
        Description.Text := DataForm2.NotesQuery.Fieldbyname('Description').AsString;
        NrStr := DataForm2.NotesQuery.Fieldbyname('Nr').AsInteger;
        FromWhere.Caption := DataForm2.NotesQuery.Fieldbyname('FromWhere').AsString;
        UserDisplay.Caption := DataForm2.NotesQuery.Fieldbyname('NoteBy').AsString;
        If DataForm2.NotesQuery.Fieldbyname('AttentionDate').AsInteger = 0 then
        begin
          Reminder.Checked := False;
          ReminderDate.Date := date;
          ReminderDate.Enabled := False;
          ReminderTime.Time := time;
          ReminderTime.Enabled := False;
          Cancel.Checked := False;
          Cancel.Enabled := False;
        end
        else
        begin
          Reminder.Checked := True;
          ReminderDate.Date := StrtoDate(IntDatetoString(DataForm2.NotesQuery.Fieldbyname('AttentionDate').AsInteger));
          ReminderDate.Enabled := True;
          ReminderTime.Time := StrtoTime(DataForm2.NotesQuery.Fieldbyname('AttentionTime').AsString);
          ReminderTime.Enabled := True;
          Cancel.Checked := StrtoBool(DataForm2.NotesQuery.Fieldbyname('Completed').AsString);
          Cancel.Enabled := True;
        end;
    end
    else
      showmessage('You don''t have permission to change a note!');  }
end;

end.
