       IDENTIFICATION DIVISION.
       PROGRAM-ID.    MF110CB0.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-FLAG PIC X(01) VALUE SPACES.
          88 FLAG-YES       VALUE 'Y'.
          88 FLAG-NO        VALUE 'N'.
          COPY MF110BMS.
       PROCEDURE DIVISION.
       A000-MAIN-PARA.
            PERFORM 100-INITIALIZATION.
            PERFORM 200-SEND-MAP.
            PERFORM 300-RECEIVE-MAP.
            PERFORM 400-VALIDATE-FILEDS.
            PERFORM 500-EXIT.
       100-INITIALIZATION.
           MOVE LOW-VALUES TO MF110BMSI.
           MOVE LOW-VALUES TO MF110BMSO.
       200-SEND-MAP.
            EXEC CICS SEND
                      MAP('MF110BMS')
                      MAPSET('MF110BMS')
                      FROM(MF110BMSO)
                      ERASE
            END-EXEC.
       300-RECEIVE-MAP.
            EXEC CICS RECEIVE
                      MAP ('MF110BMS')
                      MAPSET('MF110BMS')
                      INTO(MF110BMSI)
            END-EXEC.
       400-VALIDATE-FILEDS.
            CALL 'MF110CB2' USING MF110BMSI
                                  MF110BMSO
                                  WS-FLAG.
            IF FLAG-YES
               CONTINUE
            ELSE
                CALL 'MF110CB3' USING MF110BMSI
                                     MF110BMSO
            END-IF.
            PERFORM 200-SEND-MAP.
        500-EXIT.
            EXEC CICS RETURN
                 TRANSID('MF110')
            END-EXEC.








