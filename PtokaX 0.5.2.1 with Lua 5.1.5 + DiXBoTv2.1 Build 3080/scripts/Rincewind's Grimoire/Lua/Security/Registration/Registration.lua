LuaQ                   $      $@  @  $�  �  $�  �  $    $@ @ $� � $� �  �       RegistrationCreateUser    RegistrationRegme    RegistrationChangeUser    RegistrationDeleteUser    RegistrationGetPassword    RegistrationChangePassword    RegistrationMessage    RegistrationLogShow           A     �   �   �@@� � �  � �A�  � �AA��A  @ �A� � �   B@@� �B ��W�B� �W��@ ��B �E� �C � D �C@�\C�B� ^ E� F�� \� Z  @�E� �C �   DDED F���� � � @�\C�B� ^ C� @ � C   �C � �E@ � �FD F�F D�@@ �@ �	�  DDED F��� � � � � FC � �� �D�  DDE  FD��  �DD	�D �D�	� FC �� ��   \� � � � � � A� � ��� D��  Z   �D �H@ D � �HE �����  I��  DDE  FD��D �DI	�   \� �� � � � � FC � �� �D��	 �I@ �    �
 @ ���  @�� D� �
 @ ���  @�� �C D   DDE  FD��D �DJ	�   \� �� � � �   DD@��� �C � � � A� � ��� D�D �J�@ ��
 KAD � E� F��� �DL	��@	� ��	�� \������
 K
A � AE � ��  A� �C � �
�D��D��D �   � :      string    find    %$To:%s(%S+)       �?   tBots    tRegistration    sName             "   %b<>%s+%S+%s+(%S+)%s+(%S+)%s+(%d)     SendMessage    sNick    tScriptMessages    sRegCreateSyntax    RegMan    GetReg    gsub    sRegUserAlready    !username! 	   tonumber    Unreg    ProfMan    GetProfile    sProfileName    tRegistrationAdd 	   iProfile    sRegUserCreateFailedUser 
   !profile!    sRegUserCreateFailedOp 
   !addedby!    ops    sNewUsername    tRegistrationSettings    sPrefix    AddReg    sRegUserCreated    Core    GetUser    RegistrationMessage    sRegUserCreatedOp 	   bKeepLog    os    date    RegLog-%Y-%m-%d.txt    io    open    tSettingPaths    sRegistrationLogs    a+    write 	   %H:%M:%S     -           has been registered by     
    close                     G   l     �   �   �@@� � �  � �A�  � �AA��A  @ �A� � � B �BF�B �    � F�B � �B Ƃ� �B��    B@@� �� � D���  �B�  CDEC F���� � �C�� A� �� �F܂ ��� �B @ �����B��� � �B Ƃ������B �B��B ���� �B ��� @ �C �B �  �B�C �GA� ��B ܂ ���  @ ���� �B��B   @���B ��   A� �B��B ��������	 �B��	 ܂ �	 JEC
 F��F����U����
 ��KK�	 �C�D ܃ � E� �� Ճ�\C�KL\C @�� �B @ �C �CL���B��  �B�  CDEC F���� ��B � A� � ܂ ���  @ �����B� � 5      string    find    %$To:%s(%S+)       �?   tBots    tRegistration    sName                RegMan    GetReg    sNick    SendMessage    tScriptMessages    sRegmeAlready    %b<>%s+%S+%s+(%S+)     gsub    sRegmeSyntax 	   !prefix!    tGeneralSettings    sPrefix    !regme!    tScriptCommands    sRegme    tRegistrationSettings    bAllowRegme    sNewUsername    AddReg       @	   sRegmeOp    !username!    ops    RegistrationMessage    Reg 	   bKeepLog    os    date    RegLog-%Y-%m-%d.txt    io    open    tSettingPaths    sRegistrationLogs    a+    write 	   %H:%M:%S     -      used self-registration
    close    sRegmeSent    sRegmeSentOp    !password!    opchat                     r   �       �   �@@� � �  � �A�  � �AA��A  @ �A� � �   B@@� �B B�W�B@ ��� �� FC � �C ƃ� �C��  � D@ � �B@�E� �C �   DDED F���� � � @�\C�B� ^ FE�C ���� � ���� ��E	� �� @ 	� �DF ��	��	�@	@�� �DF ��	�D���	�@	������ ��F	���� �G	���� ��F	���� �  ���� ��F	���� �G	�D @ ��� �D �� ��F	�D��� �  @��� ��F	�D��� G	  �� �� �C   E  FE�
�  �ED�E ��� @ �� �E F \� ���D��  �DD	�  �D�	  ED
E  FE�
�E ��H�� C \� �� � � A � ܄ E EE �� � 	�� �	   @��� �D��� � �  @��B	 ��	 ��I	�@	 ��
 �DJ	��
 �� ��
 ��	E �K
�@
@ 	E
A� ܄��	�
 �EJ�E �� ��   A� ��� C AG �EE���	E �� ��M	�D	  �@ �� �  ���  �DD	�  �D�	E N
A� � ܄  @��� � 	�� �C   @����D��D �  �@ �E	 �� ��D��  �DD	�  �D�	  ED
EE F��
�� �C � A� � ܄  @��� � 	�  �DD	��� FC �� � 	�� �C   @��� �D��� �  � <      string    find    %$To:%s(%S+)       �?   tBots    tRegistration    sName                %b<>%s+%S+%s+(%S+)%s+(%d+)     SendMessage    sNick    tScriptMessages    sRegChangeSyntax    RegMan    GetReg    gsub    sRegChangeUnreg    !username! 
   sPassword 	   tonumber    Core    GetUser    tRegistrationAdd 	   iProfile    ProfMan    GetProfile    sProfileName    sTargetFailed    Unknown    sRegChangeFailedUser 
   !profile!    !targetprofile!    sRegChangeFailedOp    !changedby!    ops    sNewUsername    tRegistrationSettings 	   bKeepLog    os    date    RegLog-%Y-%m-%d.txt    io    open    tSettingPaths    sRegistrationLogs    a+    write 	   %H:%M:%S     -  (    has had their registration changed to      by     
    close 
   ChangeReg    sRegChangeChanged    RegistrationMessage    sRegChangeChangedOp    !changeby!                     �   �     �   �   �@@� � �  � �A�  � �AA��A  @ �A� � �   B@@� �B ��B ���B E FC�F��� �CC�B �� � ł ���  ܂ ����  DE FC��� � � � � FE � �� �C��  C�C���� � FE� � DFE� ��E F���� F����@ ��� �	�E  F�� ��F	�   \� ��E� �E �  �@�\D�E  F��  �D	�  ��	 EG
A� �E ܄ � @ �� �   \� ��E� �� �  �A� \D�B� ^ �  @�E FD�����E� F���	 \� �D	 ��I	��	 ��	���	 ���	E
 ���˄J	E� F��
��
 \� � � F FE �� U��
�D���K	�D E� F�� \� Z   �E  F�� �DL	�� E \� ��E� ���  �A� \D�E  F�� ��L	��   \� ��E� �E �  �@�\D�E  F��  �D	� ���	� @ �� �� E \� ��E� �E �  �A� \D�B� ^  � 4      string    find    %$To:%s(%S+)       �?   tBots    tRegistration    sName                %b<>%s+%S+%s+(%S+)  	   SendData    tScriptMessages    sRegDeleteSyntax    RegMan    GetReg    gsub    sRegDeleteNo    !username!    SendMessage    sNick 
   sPassword 	   iProfile    ProfMan    GetProfile    sProfileName    tRegistrationDelete    sRegDeleteFailed 
   !profile!    sRegDeleteFailedOp    !deletedby!    ops    tRegistrationSettings 	   bKeepLog    os    date    RegLog-%Y-%m-%d.txt    io    open    tSettingPaths    sRegistrationLogs    a+    write 	   %H:%M:%S     -  (    has had their registration deleted by     
    close    DelReg    sRegDeleteDeletedNick    sRegDeleteDeleted    sRegDeleteDeletedOp                     �        �   �   �@@� � �  � �A�  � �AA��A  @ �A� � �� E  FB��� �B \��  @�� �B@�� � ��� �BFC � � �  ��  CCE� F��� �C��   � FC � �  �C���� FC � Ń ��� �C��   �@�� FC � �  �C�� DEA� ��܃  �C��  � E� F��C�\� F���� �CF ���C����@  ��  �@�	��  �CC�  �C�� GA� ��܃  FD���   �� �C   @ ���C��  �CC�  �C�� DGA� ��܃ � FC ��   �� ��   @ �� �C����� �C   E  FD��� �H	��  �\� ���C��  �CC�  �C�� DHA� ��܃ � FC ��   �� ��   @ �� �C� � "      string    find    %$To:%s(%S+)       �?   tBots    tRegistration    sName                %b<>%s+%S+%s+(%S+)    RegMan    GetReg    sNick    gsub    tScriptMessages    sRegPasswordShow    !password! 
   sPassword    SendMessage    sRegPasswordNone     sRegPasswordUnreg    !username!    ProfMan    GetProfile 	   iProfile    sProfileName    tRegistrationGetPassword    sRegPasswordGot    sRegPasswordGotOp    !requestedby!    ops    sRegPasswordNo    sRegPasswordNoOp                     &  c    �   �   �@@� � �  � �A�  � �AA��A  @ �A� � �   B@@� �B B��B��  C@@� �� ��B �� DC @ �� ��C	���C��� � � �C�DC @ ��D �C � DC @ �� ��D	���C�� �C����.�Ń ��� ܃ D �FE� F�F����U���D ��K�Gń ���	� ܄  FEC �E Մ�	\D�K�H\D @(�W�B@ ��� � FCC � Ń ��� �C��   CI@ � 	 	 C  ��  �IE� F���
 � � �  FCC � �� �C��  	 CJC
 � E�
 ��D F���	 ��DF����  ��  �@ �E FC�� ��	 �D\C E  F���  ��IŃ ���
 @ �� �  �\� ��E �CC �  �@�\C�E  F���  ��IŃ �C�
 @ �� �� DC \� ��E �� �  �A� \C�E FC��� �E� F��� \� �C ��F�� ����� ���D ���˃GE� F���� \� � �  FEC �E U���C�˃H�C  �E  F���� ��L�
   \� ��E �CC �  �@�\C�E  F���  ��IŃ ���
 @ �� �� DC \� ��E �� �  �A� \C� � 4      string    find    %$To:%s(%S+)       �?   tBots    tRegistration    sName                %b<>%s+%S+%s+(%S+)%s+(%S+)     %b<>%s+%S+%s+(%S+)    SendMessage    sNick    tScriptMessages    sRegPasswordChange    RegMan 
   ChangeReg 	   iProfile    sRegPasswordChanged    tRegistrationSettings 	   bKeepLog    os    date    RegLog-%Y-%m-%d.txt    io    open    tSettingPaths    sRegistrationLogs    a+    write 	   %H:%M:%S     -      has changed their password
    close    sRegPasswordChangeSyntax    tExistingUser    GetReg    gsub    sRegPasswordChangeUnreg    !username! 
   sPassword    tRegistrationChangePassword    sRegPasswordChangeChanged    !password!    sRegPasswordChangeChangedOp    !changedby!    ops $    has had their password changed by     
    sRegPasswordChangeNo    sRegPasswordChangeNoOp                     i  �    e   �    �  @�EB  F���B  ��@��  ��C @��� ��  �\�  �A� � � ��� �A� ��  �BB� ���EB  F������  �\� ��@��� Ձ�@��� � �B�� �C܂  ��@��B � �B�� �D܂ � E FC��� �E\� � Ձ�@��B �� ��@��� �  ��@��� �� ��@�� ��  �B� ��@��� Ձ��  ��E� � �   �A \B�@�E� � �   �A \B� �           string    gsub    tScriptMessages    sRegMessage    !username! 
   !profile!    
		    

    sRegMessageNick Y   		������������������������������������������������������������������������������������
    		�� Hub Name	:     SetMan 
   GetString    tStringSettings 	   bHubName    
    		�� Hub Address	:     bHubAddress    : 
   bTCPPorts    		�� Your Nick	:     		�� Your Password	:     		�� Your Profile	:     		�� 	    sRegMessageWarning [   		������������������������������������������������������������������������������������

    SendMessage                             �  �    o   �   �@@� � �  � �A�  � �AA��A  @ �A� � � �A�� ܁ � CAB �� ����B�� E  F��B ��D�� \��� �@ �B �B Ƃ�� �@ �B �  ��C �DA� ܂� �@ �B �B Ƃ�� �A� � �BFł ������ ��� ����  ��˂G܂ �B �B �   �L��� C EC F���� �C  �˂G܂ �B ��� C EC F���� ��� C E  F��C ��D�� \��� ��� CH E FC�F��� ���B� � "      string    find    %$To:%s(%S+)       �?   tBots    tRegistration    sName            os    date    RegLog-%Y-%m-%d.txt    Core    SendToNick 
   Rincewind    !    

		    rep    tGeneralSettings    sBorder       >@   
    		     Log Detail
     
    io    open    tSettingPaths    sRegistrationLogs    r    line    read          SendMessage    sNick                             