class AlarmInfo {

  DateTime alarmDateTime;
  DateTime whatDays;
  bool vibration;
  bool drzemka;
  bool isActive;

  AlarmInfo(this.alarmDateTime, this.whatDays, this.vibration, this.drzemka, this.isActive);
  AlarmInfo.copy(AlarmInfo alarm): this(alarm.alarmDateTime,alarm.whatDays,alarm.vibration,alarm.drzemka,alarm.isActive);
}

