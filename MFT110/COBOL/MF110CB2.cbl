       IDENTIFICATION DIVISION.
       PROGRAM-ID.    MF110CB2.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PGM-VAR.
          05 WS-CURR-DATE     PIC X(16).
          05 WS-NBR-DAYS      PIC S9(08) COMP.
          05 WS-NBR-CDAYS     PIC S9(08) COMP.
          05 CMN-DISP-DATE    PIC X(8).
          05 CMN-DISP-DATE-NM PIC 9(8).
          05 WS-CLAIM-DATE.
             10 WS-YEAR       PIC X(4).
             10 WS-MONTH      PIC X(2).
             10 WS-DAY        PIC X(2).
       LINKAGE SECTION.
          COPY MF110BMS.
       01 WS-FLAG PIC X(01) VALUE SPACES.

       PROCEDURE DIVISION USING MF110BMSI
                                MF110BMSO
                                WS-FLAG.

       B000-MAIN-PARA.
           PERFORM 100-VALIDATION-OF-FILEDS
           GOBACK.
       100-VALIDATION-OF-FILEDS.
           INITIALIZE WS-FLAG
            IF OPTIONI = '1'
            IF claiminpI = 0
              MOVE 'CLAIM NUMBER IS NOT VALID' TO MESSAGEO
              MOVE 'Y' TO WS-FLAG
           ELSE
            IF claiminpI IS NUMERIC
                MOVE 'N' TO WS-FLAG
              ELSE
                MOVE 'PLEASE ENTER NUMERIC VALUES' TO MESSAGEO
                MOVE 'Y' TO WS-FLAG
              END-IF
           END-IF
           ELSE
           IF OPTIONI = '2'
                 MOVE claimdtinpI(1:4) to WS-YEAR
                 MOVE claimdtinpI(6:2) to WS-MONTH
                 MOVE claimdtinpI(8:2) to WS-DAY
                 MOVE FUNCTION CURRENT-DATE TO WS-CURR-DATE
                 IF WS-CLAIM-DATE > WS-CURR-DATE(1:8)
                    MOVE 'Y' TO WS-FLAG
                    MOVE 'DATE MUST BE PAST' TO MESSAGEO
                 END-IF
                 IF paidinpI > valueinpI
                    MOVE 'PAID AMT SHOULD BE <= TOTAL' TO MESSAGEO
                    MOVE 'Y' TO WS-FLAG
                 END-IF
              ELSE
                    MOVE 'ENTER THE CORRECT OPTION' TO MESSAGEO
                    MOVE 'Y' TO WS-FLAG
              END-IF
           END-IF.

