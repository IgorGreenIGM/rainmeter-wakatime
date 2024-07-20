; Variables.inc
[Variables]
@include=#@#Include\CommonVars.inc

Scale=((1.255*#SCREENAREAWIDTH#)/2880)
BaseWidth=600
BaseHeight=350
Width=#BaseWidth#*#Scale#
Height=#BaseHeight#*#Scale#
SkinVisibleWidth=(580*#Scale#)
SkinVisibleHeight=(364*#Scale#*#SCREENAREAHEIGHT#/1620)
TopBottomBarPadding=50*#Scale#
LeftRightBarPadding=35*#Scale#
GraphPadding=20*#Scale#
BarWidth=((#Width#-(2*#LeftRightBarPadding#))/7)
MaxBarHeight=(#Height#-#TopBottomBarPadding#-#GraphPadding#)
WeeklyBaseURL=https://wakatime.com/api/v1/users/current/durations
FetchUpdateDivider=900 ;15 minutes
GlobalUpdateDivider=900; every 15 minutes

; current date
DatePadding=10
DateFontSize=(8.8*#Scale#)
DateFontColor=255,255,255
DateFontFace=Metropolis Extra Light

DayInfoTopBottomMargin=40
DayInfoLeftRightMargin=20
DayInfoHorizontalBarHeight=50
DayLongDateX=(504*#Scale#)

;Colors
ColorAxis=255,255,255
BarTransparency=255
ColorBarDeactivated=211,211,211,#BarTransparency#
ColorDayOne=23,63,95,#BarTransparency#
ColorDayTwo=251,133,0,#BarTransparency#
ColorDayThree=147,122,255,#BarTransparency#
ColorDayFour=248, 219, 70,#BarTransparency#
ColorDayFive=33,155,236,#BarTransparency#
ColorDaySix=255,61,154,#BarTransparency#
ColorDaySeven=126,211,72,#BarTransparency#
