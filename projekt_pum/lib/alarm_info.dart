class AlarmInfo {
  String opis;
  DateTime alarmDateTime;
  bool isActive;

  AlarmInfo(this.alarmDateTime, {this.opis});
  AlarmInfo.copy(AlarmInfo alarm): this(alarm.alarmDateTime,opis:alarm.opis);
}

