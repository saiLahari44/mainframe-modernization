       IDENTIFICATION DIVISION.
       PROGRAM-ID.    MF110CB3.
       AUTHOR. SAI LAHARI.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-CLAIMNBR      PIC S9(9).
           EXEC SQL
              INCLUDE SQLCA
           END-EXEC.
           EXEC SQL
              INCLUDE CLAIMS
           END-EXEC.
       LINKAGE SECTION.
          COPY MF110BMS.
       PROCEDURE DIVISION USING MF110BMSI
                                MF110BMSO.
       C000-MAIN-PARA.
           EVALUATE OPTIONI
           WHEN '1'
               PERFORM 100-CLAIM-INQUIRY
           WHEN '2'
               PERFORM 200-CLAIM-ADD
           END-EVALUATE
           GOBACK.
       100-CLAIM-INQUIRY.
           MOVE claiminpI(4:7) TO WS-CLAIMNBR
           DISPLAY 'WS-CLAIMNBR : ' WS-CLAIMNBR
           MOVE WS-CLAIMNBR TO CLAIMNUMBER OF CLAIMS
            EXEC SQL
              SELECT CLAIMDATE,
                     PAID,
                     VALUE1,
                     CAUSE,
                     OBSERVATIONS
              INTO  :CLAIMS.CLAIMDATE,
                    :CLAIMS.PAID,
                    :CLAIMS.VALUE1,
                    :CLAIMS.CAUSE,
                    :CLAIMS.OBSERVATIONS
              FROM MFTR110.CLAIMS
              WHERE CLAIMNUMBER = :CLAIMS.CLAIMNUMBER
            END-EXEC.
           EVALUATE SQLCODE
            WHEN 0
              MOVE FUNCTION DISPLAY-OF(CLAIMDATE)  TO claimdtinpO
              MOVE FUNCTION DISPLAY-OF(CAUSE) TO causeinpO
             MOVE FUNCTION DISPLAY-OF(OBSERVATIONS) TO observationinpO
              MOVE PAID of CLAIMS TO  paidinpO
              MOVE VALUE1 OF CLAIMS TO valueinpO
            WHEN 100
              MOVE 'CLAIM NOT FOUND' TO MESSAGEO
            WHEN OTHER
              MOVE 'SQL ERROR' TO MESSAGEO
           END-EVALUATE.
       200-CLAIM-ADD.
              MOVE claiminpI(4:7) TO WS-CLAIMNBR
              MOVE WS-CLAIMNBR TO CLAIMNUMBER OF CLAIMS
              MOVE claimdtinpI TO CLAIMDATE
              MOVE paidinpI TO PAID OF CLAIMS
              MOVE valueinpI TO VALUE1 OF CLAIMS
              MOVE causeinpI TO CAUSE OF CLAIMS
              MOVE observationinpI TO OBSERVATIONS OF CLAIMS
                EXEC SQL
                   INSERT INTO MFTR110.CLAIMS
                          (CLAIMNUMBER,
                           CLAIMDATE,
                           PAID,
                           VALUE1,
                           CAUSE,
                           OBSERVATIONS)
                   VALUES (:CLAIMS.CLAIMNUMBER,
                           :CLAIMS.CLAIMDATE,
                           :CLAIMS.PAID,
                           :CLAIMS.VALUE1,
                           :CLAIMS.CAUSE,
                           :CLAIMS.OBSERVATIONS)
                END-EXEC.
           EVALUATE SQLCODE
             WHEN 0
                 MOVE 'CLAIM ADDED' TO MESSAGEO
             WHEN -803
                 MOVE 'DUPLICATE CLAIM' TO MESSAGEO
             WHEN OTHER
                 MOVE 'SQL ERROR' TO MESSAGEO
                END-EVALUATE.
