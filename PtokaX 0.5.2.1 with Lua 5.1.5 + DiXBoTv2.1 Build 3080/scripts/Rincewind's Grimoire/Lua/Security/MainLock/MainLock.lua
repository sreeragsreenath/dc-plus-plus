LuaQ                   $      $@  @   �       MainLockCheck    MainLockToggle                6   �   �@@ƀ@ �� �@@ ��   �  �  �@ ƀ�� BAA ܀�� A� �� �B� � BAB �B ��C�� ��C E� F���� � � BA �C ��A�� ��D ���� ���@ �E E� F��F�� ��  �@�� � �   �       tMainLockSettings    tExemptProfiles 	   iProfile       �?   

	    string    rep    tGeneralSettings    sBorder       D@   
    	    
	         gsub    tScriptMessages    sMainChatLocked    !username! 
   tMainLock 
   sLockedBy    

    SendMessage    sNick    tBots    sName                        ,     b   �   �   A  �@�@@�A  	A�A  	��� �AE FA��� ��B � �   AA �� �A@��C�� A��@ @�A  	�@�A  F�B 	A��� �AE F���� ��B � �   AA �� �A@��C�� A���  E� FA��� ��E� \���A �� � �EA� �� ��E� � �AE� F��� �CG�� �B \� �� � � A� �� ��E�� � DEE� F��� ��A� AE � Ł �A����  A�  \A� � !       
   tMainLock    bLocked       �? 
   sLockedBy    string    gsub    tScriptMessages    sLockMainUnlocked    !username!    sNick    SendMessage    ops    tBots    sName         	   UNLOCKED    sLockMainLocked    LOCKED    

	    rep    tGeneralSettings    sBorder       D@   
    	    
	         sLockMainMessage    !mode!    

    all                             