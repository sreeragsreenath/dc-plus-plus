LuaQ                   $      $@  @  $    $ΐ  ΐ  $    $@ @ $  $ΐ ΐ         CalculateShareSize    SendMessage    GlobalSendMyINFO    LowerNicksInTables    LoadTextFile 	   LoadFile 	   SaveFile    SerialiseFile                :   E   F@ΐ    \ ΐ @E   Fΐΐ   Ε@ Οΐ  \ U ^   
E   F@ΐ    \ ΐΑ @E   Fΐΐ   Ε  Οΐ  \@ U ^   E   F@ΐ    \ Β @E   Fΐΐ   Εΐ Οΐ  \  U ^   E   Fΐΐ   Ε@ Οΐ  \ U ^          string    len       @   format    %.2f    kb     KiBs       $@   mb     MiBs       *@   gb     GiBs    tb     TiBs                        E         @ ΐ@ΐΐZ      Α@A  ΑA   UA    Α@@ A ΐ  A@  A@ΐA  @ΐ   BA  ΑA   UA    AB@  AB    ΑB@ A ΐ @     @ΐ@  AC@   ΐ B @ AA  C@   ΐ A ΐΑ D@ A A    Α @ΐΐWΐΔ @  Ε @  BE@   Bΐ  BE@   ΐ C @ BB@Δ@  BE@   ΐ  Γ @  ΐ D @BB@  BF@   ΐ B         all       π?   Core 
   SendToAll    <    >     SendPmToAll    ops 
   SendToOps    SendPmToOps    opchat    SendToOpChat 	   tonumber    SendToProfile    SendPmToProfile    string    find    (%S+)%|(.+)        @   rc     SendToNick    $To:      From:      $<    SendPmToNick                     K   q     {   Ε   Ζ@ΐ  A  ά ΐΐ   ΐ BAΐ ΐ@@    ΒA B B   @B Ε  ΖΒ ά Β  @ AΒ    C Bΐ
B    
B Ε  ΖΒ ά Β  ΐB Ε  ΖΒ ά ΒCΑΒ       BAΐ  B DΕ ΖΒΔΒ   B DΕ ΖΒΔΒΑΒ         	   @ ΖBE  A ΑΓ   AΔ Α   A Α UΓ B  ΑB  A ΑΓ   AΔ Α   A Α UΓ B        string    find 7   $MyINFO $ALL (%S+)%s+([^$]*)$ $([^$]*)$([^$]*)$([^$]+)     Core    GetUser 
   tSwitches    bHideShare       π?   tHideShareUsers    lower            bDescriptionTags    tDescriptionTags    sTag         tNick    tDescriptionTagSettings 
   tProfiles 	   iProfile    SendMessage    sNick    $MyINFO $ALL     $ $    $    all                     w         	a   
   E   F@ΐ ΐ  ΐ  J   Gΐ  E     \ @Α  ΕA ΖΑ  ά Aa  ΐύEΐ   @BΕΐ  Α  \@ E   FΒ Wΐ ΐE   FΐΒ Wΐ ΐE   F Γ Wΐ ΐE   F@Γ Wΐ ΐE   FΓ Wΐ ΐ E   FΐΓ ΐ    J   G  E     \ @ ΕA ΖΑ  ά Aa  ΐύEΐ   @DΕ   \@ E   FΔ ΐ  ΐ J   Gΐ E     \ @Α ΕA ΖΑ  ά Aa  ΐύEΐ    EΕΐ Α \@      
   tSwitches    bIntroOutro       π?   tAsciiIntro    pairs    string    lower 	   SaveFile    tSettingPaths    sAsciiIntro    bTrivia    Numbers 	   bAnagram    bGuess 	   bHangman    bCodeBreaker    tScoreClearers    sQuizScoreClearers    bSpells    tSpellWards    sSpellWards                     €   Ώ           Ε@    Α@@   ά  A Ϊ   ΐ@ ΑΒ Z   @E FAΒ Α ΒΒ \  FΓ W@Γ E FΑΓΓ \ ΔE FAΒ ΑA   \  E FAΒ Α Β E\  E FAΒ ΑA  ΒEE FBΖ \   E FAΒ Α  ΒEE FΒΖ A  ΒEΕ ΖBΗ \  E Z  ΐE FAΒ ΑΑ  H\  E FAΒ ΑA  H\  E FAΒ ΑΑ  I\  E FAΒ ΑA	  I\  E FAΒ ΑΑ	  JAB
  \   E FAΒ Α
 Β
 \  KΛ\A     -      

    assert    io    open    r    Unreg    read    *a    string    gsub    !nick!    sNick 	   iProfile       πΏ   ProfMan    GetProfile    sProfileName 
   !profile! 	   !prefix!    tGeneralSettings    sPrefix 
   !hubname!    SetMan 
   GetString    tStringSettings 	   bHubName    !hubaddress!    bHubAddress    : 
   bTCPPorts    tWelcomeInfoSettings    !networkname!    sNetworkName    !networkfounder!    sNetworkFounder    !networkfounded!    sNetworkFounded    !hublistaddress!    sHublistAddress    |    char      ΐd@   
    
    close                     Ε   Ι     	   E   @@ \ Z    E  @@ \@      	   loadfile       π?   dofile                     Ο   Φ     	   Ε   Ζ@ΐ@ AΑ  άΑA ΐ   A  ΑA ΑΑA         io    open       π?   w+    write    SerialiseFile    flush    close                     ά   ς     j   Ε      AA  ά@Ε     A  ά@Ε   Α  @   W A  A   AA ά@Ε   Α  @  WA  A   AΑ ά@@      Α   @  ΑA Υΐ @   EΒ  \ ΑE FΒΒ ΐ\ZB   E FΒΒB ΐ\Β  ΐ   A@Ε   @ ΑΓ Γά Υΐ@Β  ΐ  A ΒBΑ   B   B ΐ  ΐ  AΓ Α   Υ ΑΒ Υΐ!   ρ @  Υή          assert    tTable equals nil    sTableName equals nil    type    table    tTable must be a table!    string    sTableName must be a string!         = {
    pairs    format    [%q]    [%d]    SerialiseFile    	    %q 	   tostring     =     ,
    }                             