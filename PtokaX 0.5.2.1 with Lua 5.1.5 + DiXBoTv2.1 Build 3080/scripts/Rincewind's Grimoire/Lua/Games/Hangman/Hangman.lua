LuaQ                -   $      $@  @  $�  �  $�  �  $    $@ @ $� � $� � $    $@ @ $� � $� � $    $@ @ $� � $� � $    $@ @ $� � $� � $    $@ @  �       HangmanStartGame    HangmanStopGame    HangmanQuestion    HangmanLostLife    HangmanGuess    HangmanLoadAscii    HangmanSetScores    HangmanReadScoresFromFile    HangmanWriteScoresToFile    HangmanShowScores    HangmanMixPhrase    HangmanClearScores    HangmanArchiveScores    HangmanMaintainPlayers    HangmanShowArchive    HangmanQuestionPause    HangmanTimeOut    HangmanAutoStart    TriggerHangman    TriggerHangmanAutoStart    TriggerHangmanQPause    TriggerHangmanTimeOut           )     �   �@  �   ��  ��@ A���@ ��A�� � ��@ �� �@B��� �� �  CEA AA� �@ �� �� �  W D  ��@ ƀ�A �DE� F��A ƁE � A� � �A � �܀ � ����@ ƀ�� �FA� � �A � �܀ � ��  �� ŀ  �@��� ���  EA F��F���	 � B	 �Ł  �A��@��� ǀ	 ��	 �@� ����  EA F��F���A ��D�A Ɓ�B �DE� F��B
 ł
 ���� A �B ��K܁ � EB F��F���� �� �@��  A � ��� @ �B ��H��H�	   AC	 �B��  CGB��  @��  ǀ	 ŀ � E�  F��� N���� �@  � 5      gsFunction    HangmanStartGame    tHangmanSettings    bManualStart            TmrMan    RemoveTimer    tTimers    TriggerHangmanAutoStart  	   RegTimer    TriggerHangmanTimeOut 	   iTimeOut    Minute    sGameInProgress    Hangman        string    gsub    tScriptMessages    sQuizStartedBy    !username!    sNick    !game! 
   gsVersion         sQuizStarted    sHangmanPhrase    hdgiegdfhg erhughfgok    bPlayInMain       �?   SendMessage    all    tBots 	   tHangman    sName    

		    
    iHangmanQuestion    HangmanQuestion    sHangmanStarting 	   !prefix!    tGeneralSettings    sPrefix 
   !command!    tScriptCommands 
   sHangJoin    !bot!    pairs    tHangmanPlayers    TriggerHangmanQPause    iQuestionsPause    Second                     /   O     y   �@  �   �� ���  �@Aŀ ��� EA �� �� U���� ��  ���  �@A�  �@�� CAA ��C ܀  EA �� �� U���� ��  �� �  A �D�@��@ ��D E@��@ �� � FAFA� ��  �� U���A ��D�@��@ �� � FAFE �A ��D�@����@ ŀ �  ��A  �E� F�FB��� ��  � ��B ����A��A  �E� F�FB�� �B ����A���   ��� �   �@��� �@  �@��� ��  �@�� 	 �� �@ �@I I@���	 � 
 �@�A �JE�
 AA�	 ܀������  ��  � ,      gsFunction    HangmanStopGame    TimeOut 	   sMessage    string    gsub    tScriptMessages    sQuizStopped    !game! 
   gsVersion         sGameInProgress    sQuizStoppedBy    !username!    sNick    HangmanSetScores        tHangmanSettings    iTopScores    bPlayInMain       �?   SendMessage    all    tBots 	   tHangman    sName    

		    
    sScoresOutput    pairs    tHangmanPlayers    RemoveTimer    TriggerHangman    TriggerHangmanQPause    TriggerHangmanTimeOut    iHangmanLostLife            bManualStart    tTimers    TriggerHangmanAutoStart    TmrMan 	   AddTimer    iAutoStartDelay    Minute                     U   �      /  @     �  E�  F �  � @�� �A E  F@� �� ��  EA �@�� @ � A� ��  � D@��  @D �D @�� A  �@ ��E��E�  A AA �@��  AD@�� A  �@ ��E��Eŀ �  AD@���� E    �E� ���A Ɓ���� EB �B �E�  FB�\A�E� ���A Ɓ����� E�  FB�\A�!�   �@ A� �� @�@ A� �� @�@ A  �� @��  @H �H @�� E@	 F�� ��  ��I� 
 �� � 	 \��	@ �   @  1��
 �J E  F@� F�� �� ��@
 @
 �K ��� �A E� F�� �  � L�� � A �A �\� �@ ��  ƀ�� @ � A� �@ ��E��E�@ � @� �    � �� �@
 � �AA ܀�� �ME FA�\� A  ��  �A
 M�� Ł ��� �܁ ́�A A
 O�A �A � @ �   ��D�O��A�  �A
 PA � �P@� � A  � 
  A 
  � 
  � �  � A � �REA � A� �� � � ���� ��R�B  �E� F���C \� MC�L��N��� @ �B �B��� ��  �B��� ł �B� �� �A��� ��A� Ɓ�� E �� Ł ���� �AE� F��� �T�B �  \� �� ��  ��� A� � ܁ �A ��  �A���@���  EB F��F���B ��  �B��A�����  � �� @ �C ��E��E�C �  DDC��   �� �A�܁� � �� �A �� � E�  F��B N���� �A  � Z      gsFunction    HangmanQuestion    iHangmanQuestion    tHangmanSettings    iQuestions 	   sMessage    string    gsub    tScriptMessages    sQuizFinished    !game! 
   gsVersion         sGameInProgress    HangmanSetScores        iTopScores    bPlayInMain       �?   SendMessage    all    tBots 	   tHangman    sName    

		    
    sScoresOutput    pairs    tHangmanPlayers    RemoveTimer    TriggerHangman    TriggerHangmanQPause    TriggerHangmanTimeOut    bManualStart            tTimers    TriggerHangmanAutoStart    TmrMan 	   AddTimer    iAutoStartDelay    Minute    filevar    io    open    tSettingPaths    sHangmanWords    r     sQuizLoadFailed    !filename!    sFile    ops    seek    end    math    randomseed    os    clock    set    random    read    *l       I@	   grimoire    close    sActualPhrase    upper    iLives       *@   tWord 	   tGuessed    tGuessedLetters    sHangmanPhrase 	   sGuessed    len    sub       �   sHiddenChar    sQuizHangmanQuestion 	   !phrase!    sQuizQuestion    !thisquestion!    !totalquestions!    !question!    iQuizStartTime    iBonusTime       &@	   RegTimer    iLostLifeTime    Second                     �   �      �   @     �  E�  M � G�  E@ \�� ��  �A���� � B�� � �A �BA� � ܀ A @� ��    �� ��C A@��  �@ � �DE@  �� ��C�@����@ ŀ �  ��  �E� F��F��  ł ����A���   ��   �� �   �  �@ ��  �@��� �� �  �  �@ ŀ � �GE AA� �@ ����  �@ � � � �  @��� ���  @��� � �� BE� F��� �B�A ��B	 @ �� ��	 �  \� ��	 �
 � AA �� ܀   �ŀ ��� �@��  A E� F��F��  Ł ����@����@ � �  � @ �� ��D�E�  � �CB��   � � )      gsFunction    HangmanLostLife        iLives       �?   HangmanLoadAscii            string    gsub    tScriptMessages    sQuizHangmanUnanswered 	   !answer!    sActualPhrase    !ascii!    tHangmanSettings    bPlayInMain    SendMessage    all    tBots 	   tHangman    sName    pairs    tHangmanPlayers    tWord    tGuessedWord    RemoveTimer    TriggerHangman    iHangmanLostLife )   jdsghihgierhvierhvbjuevierhgoiernborebio 	   RegTimer    TriggerHangmanQPause    iQuestionsPause    Second    ipairs 	   tGuessed         sQuizHangmanLostLife    !word!    !lives!    !guess! 	   sGuessed                     �   �    c  �@  �   ��  ��   �@��@ ��  � �AE AA�  �@ �@ ��B� � � � �EA F�� \� � ��B EB F���� �� \�C �C@��  A@H�C �BE� F�����  @F�C AW�D@E�� �D A�� AC ��E ��� �DC���� E @�ED FD���E \� W@���E ��ń ���	��	�E AE ���
E� F��
\D�!�  ��� EC  �@� �E� I�� !�   � AC �C Ń � ���� EH
 �	  �A �@�	UC
  @�	�� ��
�  @��� ��@ �E�  3��  @	��C ��D	 �IA�	 � ܃  �Ń ��� �@�� D E� F��F�� ń ���	�C��)���  � � @ 	�� ��F�G� � �DE��   ��%��
 �C��� ��C
 ���C
 �
 ���C
  ���Ń
 ܃� D IED F��D	 ��J	� � \� �D ���   � �D A@� AD �� ��F	�G	� � �D
D���� E  �E ��	Ņ �����  E� F��\E�!�   �� � 
  D 
  � �  A � D�D ED �� ��L	�� ��	�D D �   � ��
 �  ���C D	 �M��� �� 
 � � @ 	�� �
 �   �Ń
 ܃� D IED F��D �I	�D ��	E	 �M
A�	 � ܄  EE
 �� �D  \� �D ���   � �D A@� AD �� ��F	�G	� � �D
D���� E  �E ��	Ņ �����  E� F��\E�!�   �Ń   A �C��C  E� F���� N��� �C �� � �  �@>�� �NEC
 CE� �� �� �  �C �  �� � ƃE ���  @�� ƃE ��� �E ���C����Ã�@�� ƃE 
 F�E � "D ���� ��O�  F�E D�C��C ƃE  ���Ń ƃ� ܃  F�E DDOAD ����� �A��	�DO	� Ƅ�	�D�	M�	�� �D� �� ��D	 A	��� �D �E @��� ��D�D����� � �@��E �E��E ܅ W��
���  �
E� F��F���E �F  ��ņ ����E���  ���D �DQ	�� � R
�� E E
���� �D �I	�D ��	E I
EE	 FE�
�� ƅE � A ��܄ � E ��   	�� ��D	 A	@�� �D � �F
G
@ �� ��D�D����� � � ��  �
E� F��F�� ņ ����E���   ������D �I	�D	 ��	E E �AF��
F�
��   	@ ��D	 �S	�D �I	�D ��	E I
EE F�
�E �I�E ��  A� ��E ܅ � @ �� �   \� �E � � A� ��܄ � @���   	�� ��D	 A	@�� �D � �F
G
@ �� ��D�D����� � � ��  �
E� F��F�� ņ ����E���   ���  �  �D��D �D � �L
E� E
AE �D �� � ��� �D H��� E @�ED FD���E \� W@���E ��ń ���	��	�E AE ���
E� F��
\D�!�  ��    � T      gsFunction    HangmanGuess    RemoveTimer    TriggerHangmanTimeOut       �?	   RegTimer    tHangmanSettings 	   iTimeOut    Minute    string    find    %b<>%s+(.*)    upper        %$To:    len    sAllowedCharacters    tWord     bPlayInMain    SendMessage    all    sNick    pairs    tHangmanPlayers    lower    tBots 	   tHangman    sName    ^    ipairs 	   tGuessed            sHiddenChar         sActualPhrase    gsub    tScriptMessages    sQuizHangmanWord    !word!    tGuessedLetters    iLives    HangmanLoadAscii    sQuizHangmanUnanswered 	   !answer!    !ascii! 5   456dsgfsdgdf5sg56df4sh54fd64hh465dsfhd5f4hd64ha68fh6    tGuessedWord    TriggerHangman    TriggerHangmanQPause    iQuestionsPause    Second 	   sGuessed    
    sQuizHangmanGuesses    sQuizHangmanLostLife    !lives!    !guess!    iLostLifeTime    iPoints    tHangmanScoresByName        @   table    insert    tHangmanScores    HangmanSetScores    getn    HangmanWriteScoresToFile    iQuizStartTime    format    %.0f    os    clock    sQuizCorrectAnswer    !username!    !time!    sQuizRankBehind    !nextrank! 
   sQuizRank    !score!    !totalscore!    !rank!    !totalrank! 	   !behind!                     �  �     2   @     �  E�  F � @�  
�E� F�� F@� �  �@ U�� �� �� � � � AA � ���  �   @�ˀCA� ܀�  ��  �@�   A� � ��D� � ܀    ��  �@�   AA �� ܀   ���E�@ �      �   �       gsFunction    HangmanLoadAscii        tHangmanSettings 
   bUseAscii       �?   tSettingPaths    sHangmanAscii    iLives    .asc    assert    io    open    r    read    *a    string    gsub    |    char      �d@   
    
    close    

                     �  �    �   �@  �   ��  ��@�  �� �@ A AA  �A �A  B  @����E� F��� �B�B Ƃ�� @� �� � C \� G� � �  �E� F��B ��C� C \� G� �� @A@�A �� �B�B �B� AC �� �� UG� B� ^  �E�  F��� �  \B�A � � `� �E F�I��_��A� �� ��E� �B�� �����  CFA �C �� � A� �� ��E	� �D�	� �����  EF
A� UB�G� A �� �H��  ���� `B�  E F�F�GC E F�����H� �A G	 @ �AC	 G	 E� � � �C��	 @ ��	 �	 
 @ �E
 �E � U�G� _�E� � � �B�� E� F��� �CF�� \����
 U��G� @    @�W@@ ��E�
 F�Z  � �E�
 F�FB�^  � ,      gsFunction        table    getn    tHangmanScores            sScoresOutput    string    gsub    tScriptMessages    sQuizScoresTopX    !top!    !game!    Hangman    sQuizScoresTop      ��@   

	    sQuizScoresNone    
    sort       �?      @   

		    rep    tGeneralSettings    sBorder       D@   
		    		 
   gsVersion         math    min 
   sUserName        @      $@   anscoretabs    	    	Rank.            Score.         		    

    tHangmanScoresByName        �  �       � @ � � X��  ��@  � � �   �           @                                �  �           E@  F�� F�� @ �  E  F@� �� \� ��   ��� E� F��F���� �� 	���� �    	   loadfile    tSettingPaths    sHangmanScores       �?   table    getn    tHangmanScores    tHangmanScoresByName                     �  �     3      @@ E�  F�� F � �@ ����A � �@��  �  �@�� ܀  �@���A � @�� �B Ƃ�� E� FC�F�܂� E� FC�FC��� ��A�� ���A � E FA��� \� � ��@���A A �@���E �@  �       io    open    tSettingPaths    sHangmanScores       �?   w    write    tHangmanScores = {
    table    getn    tHangmanScores    [    ] = {    string    format    %q    ,        @   },
    n=    
    };    close                     �  �    /   �@  �   ��  ��@  � �@��  �@Aŀ ��� F�@ �� �@ ƀ������  A E� F��F�� �A ���A Ɓ��@� �ŀ � � �� @ �� ��C�D� C ��C �BB��  �� �       gsFunction    HangmanShowScores    HangmanSetScores    sNick    string    gsub    tScriptMessages    sQuizShowScores    !username!    tHangmanSettings    bPlayInMain       �?   SendMessage    all    tBots 	   tHangman    sName    sScoresOutput    pairs    tHangmanPlayers                              E   F@� �   ��@�   �  d  �� �  A ]  ^    �       string    sub    gsub    (%S+)       �?       �                E   �   \� �@  U�� ^   �       HangmanMixString                                         !    9   A@  G   A�     @ �F�@ � ��  �@AF�A�@  ���   �  �� �� �@� �  �@C�  �@�� �CA �A ܀ � @� �� �� � �@� �ŀ � E FA�F��� �A �@�@��  A � ��� @ � �BA��A� C B��  @� �       gsFunction    HangmanClearScores        sNick    tBots 	   tHangman    sName    tHangmanScores    tHangmanScoresByName    n            HangmanWriteScoresToFile    string    gsub    tScriptMessages    sScoresCleared    !game!    Hangman    !username!    tHangmanSettings    bPlayInMain       �?   SendMessage    all    pairs    tHangmanPlayers                     '  ?    \   A@  G   E�  F��  �  �J   �@ ŀ � ��Ł  ������ �Ł �A�I����  ���  �@B�� �� � A�  �@�� ܀  C@ ��@ � �� �C@ �  A� � @ �@A �DE� � E� F�� ����W��@�E� �A�  ���I�E �A ��E�� � \A E � Ł ���B FAAB ��� ��܁  �A �� � \A E� � �A Ɓ���� BHA \A� � "      gsFunction    HangmanArchiveScores    tHangmanSettings    bArchiveScores       �?   ipairs    tHangmanScores    iArchiveScores    os    date    %m    %y               (@   string    len    0    table    getn    tHangmanScoresArchiveIndex 	   SaveFile    tSettingPaths    sHangmanScoresArchiveIndex    gsub    sHangmanScoresArchive    !filename!    tHangmanScoresArchive    SendMessage    ops    tBots 	   tHangman    sName    tScriptMessages    sHangmanScoresArchived                     E  �    �   �@  �   ŀ  ��� � A � ��A ���  �AF�A �  B �AB ��  ��B�� ��C ����� � CA� � �CD�� �  �BE� F��D ��A� �� �C	�� ���E� � \��� �� � CAD � �� ��a�  @�@ �� �� ��� E�  F���� �C�C \���� ������E��E F�Z  � �E ��@�E IBFE ���E�  F��� �G�B �A \� �� ��G��E F�Z   �E I�GE ��E�  F����  ��F� �B�C F�A �� �� \����@�E �����E�  F���� �	 \��  �A@��   @I��   � � ��I�� 	C��  �FE F���� ��A � � �  �FE�  F��� �J�C   \� �� ��A � � ��@J@�   �� 	���  �FE F���� ��A � � �  �FE�  F��� ��J�C   \� �� ��A � � @ � �KAB Z    �AB �� � � LCL@ ���B��  ����� E @�W ���E� ���� ��	�D�	 �AE \D�!�  ��� E� FC�� � C  � 4      gsFunction    HangmanMaintainPlayers    string    find    %$To:%s(%S+)        lower    sNick    S    

		    rep    tGeneralSettings    sBorder       9@   
		    		    tScriptMessages    sHangmanPlayers    
    pairs    tHangmanPlayers    	     

    J    sHangmanJoinAlready       �?   sHangmanJoinUser    gsub    sHangmanJoinOp    !user!    L     sHangmanLeaveUser    sHangmanLeaveOp    !nick!    sHangmanJoinNot    %b<>%s+%S+%s+(%S+)    A    sHangmanAddAlready    sHangmanAddUser    sHangmanAddOp    D    sHangmanRemoveUser    sHangmanRemoveOp    sHangmanAddNot            SendMessage    tBots 	   tHangman    sName 	   SaveFile    tSettingPaths                     �  �    k   �@  �   ��  ��   AA@� �� �� �A� � A� ��Z    ��  �   ��B � Ƃ�� CAC ܂�� E� F��� � � E F���� �C	�D \���� �� ��	 � �B �  �DE� F�F���C � � A�  �B �B �� �� ����  E� F��D ��� F�F� ��@ � ���  @�� � � CA� � ��B�� ��D ���� ��@�� ��D�B Ƃ�� [C   �A�  �� �  � �BH � �HI@ ���B� � %      gsFunction    HangmanShowArchive           �?   string    find    %b<>%s+%S+%s+(%S+)    %$To:%s(%S+)            

		    rep    tGeneralSettings    sBorder       D@   
		    	 Hangman Scores from     
 	   LoadFile    gsub    tSettingPaths    sHangmanScoresArchive    !filename!    ipairs    tHangmanScoresArchive    		    	Rank.  
   		Score.         @   

    tScriptMessages    sHangmanArchiveNot 
   !archive!    SendMessage    sNick    tBots 	   tHangman    sName                     �  �        @     �  �@ �    @� @ A� ��  @� �       iHangmanLostLife            iHangmanQuestion       �?   HangmanQuestion    RemoveTimer    TriggerHangmanQPause                     �  �           C � �@  @� �       HangmanStopGame    TimeOut                     �  �           @@ ���  �@ @  � �  A@ �@ @� �       sGameInProgress     tMainBlock 	   bBlocked    HangmanStartGame                         �  �           @�  �       HangmanLostLife                     �  �           @�  �       HangmanAutoStart                     �  �           @�  �       HangmanQuestionPause                     �  �           @�  �       HangmanTimeOut                             