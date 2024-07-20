[Variables]
@include=#@#Include\CommonVars.inc

Scale=((1.255*#SCREENAREAWIDTH#)/2880)
ContentPadding=(16*#Scale#)
SkinVisibleWidth=(580*#Scale#)
SkinVisibleHeight=(364*#Scale#)
;
ProfilePictureWidth=(100*#Scale#)
ProfilePictureHeight=(100*#Scale#)
ProfilePictureX=(#SkinVisibleWidth#-(#ProfilePictureWidth#+#ContentPadding#))
ProfilePictureY=#ContentPadding#
ProfilePicturePath=#@#..\data\user\profile.png
ProfilePictureURL=""
;
FetchLeaderboardUpdateDivider=21600
UserCoutryCode=""
