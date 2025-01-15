%let pgm=utl-total-weekly-cost-for-breakfast-lunch-and-dinner-for-mary-jane-and-mike-sas-r-sql-python-excel;

%stop_submission;

Total weekly cost for breakfast lunch and dinner for mary jane and mike sas r sql python excel

          1 excel sql (ansi sql)
          2 sas r python (see link below for sas r python)
            https://tinyurl.com/3kww82ch
          3 base r (dplyr/tidyverse language)
            group_by summarize %>% inner_join (these are not in base)


stackoverflow
https://tinyurl.com/yc4tje93
https://stackoverflow.com/questions/79356731/join-merge-two-data-frames-based-in-string-names-and-adding-the-mean-of-other-co

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                                               |                                 |                                      */
/*    INPUT EXCEL WORKBOOK WITH 2 SHEETS         |         PROCESS                 |               OUTPUT                 */
/*    ==================================         |      SELF EXPLANATORY           |               ======                 */
/*                                               |      ================           |                                      */
/*                                               |                                 |                                      */
/* d:/xls/wantxl.xlsx sheet DF1                  | SAME CODE IN SAS R PYTHON EXCEL | d:/xls/wantxl.xlsx sheet WANT        */
/*                                               | ==============================  |                                      */
/* -----------------------+                      |                                 |                                      */
/* | A1  | fx    | NAME   |                      | select                          |  ----------------+                   */
/* ------------------------                      |   l.name                        |  | A1  | fx| NAME|                   */
/* [_]|    A     |                               |  ,avg(l.break)  as avgbreak     |  --------------------------------    */
/* ---------------                               |  ,avg(l.lunch)  as avglunch     |  [_]|    A |  B   |  C   |  E   |    */
/*  1 | NAME     |                               |  ,avg(l.dinner) as avgdinner    |  --------------------------------    */
/* -- |----------+                               | from                            |   1 | NAME |BREAK |LUNCHT|DINNER|    */
/*  2 | jane     |                               |   df1 as l                      |  -- |------+------+------+------+    */
/* -- |----------+                               | inner join                      |   2 | jane |12.29 |13.29 |12.43 |    */
/*  3 | mary     |                               |   df2 as r                      |  -- |------+------+------+------+    */
/* -- |----------+                               | on                              |   3 | mary |13.43 |11.86 |13.00 |    */
/*  4 | mike     |                               |   l.name=r.name                 |  -- |------+------+------+------+    */
/* -- |----------+                               | group                           |   4 | mike |12.00 |12.43 |12.00 |    */
/* [DF1]                                         |   by l.name                     |  -- |------+------+------+------+    */
/*                                               |                                 |  [WANT]                              */
/* d:/xls/wantxl.xlsx sheet DF2                  | FOR SAS R PYTHON SEE            |                                      */
/*                                               | ====================            |                                      */
/* --------------------+                         | https://tinyurl.com/3kww82ch    |                                      */
/* | A1  | fx    | NAME|                         |                                 |                                      */
/* ------------------------------------------    |                                 |                                      */
/* [_]|    A     |   B |   C  |    E |    F |    |---------------------------------|--------------------------------------*/
/* ------------------------------------------    |                                 |                                      */
/*  1 | NAME     |  DAY| BREAK|LUNCHT|DINNER|    | 3 BASE R                        |                                      */
/* -- |----------+------+-----+------+------+    | ========                        |                                      */
/*  2 | jane     |Mon   |11   |13    |15    |    |                                 |                                      */
/* -- |----------+------+-----+------+------+    | want<-                          |  NAME  avgbreak avglunch avgdinner   */
/*  3 | jane     |Tue   |10   |11    |11    |    |  df2 %>% group_by(NAME) %>%     |                                      */
/* -- |----------+------+-----+------+------+    |  summarize(avgbreak=mean(BREAK) |  jane      12.3     13.3      12.4   */
/*  4 | jane     |Wed   |13   |15    |11    |    |   ,avglunch=mean(LUNCH)         |  mary      13.4     11.9      13     */
/* -- |----------+------+-----+------+------+    |   ,avgdinner=mean(DINNER)) %>%  |  mike      12       12.4      12     */
/*  5 | jane     |Thu   |15   |13    |10    |    |   inner_join(df1,by=c("NAME"))  |                                      */                                    |                                      */
/* -- |----------+------+-----+------+------+    |                                 |                                      */
/*  6 | jane     |Fri   |10   |15    |15    |    |                                 |                                      */
/* -- |----------+------+-----+------+------+    |                                 |                                      */
/* ,, | ...      |...   |...  |...   |...   |    |                                 |                                      */
/* -- |----------+------+-----+------+------+    |                                 |                                      */
/* [DF2]                                         |                                 |                                      */
/*                                               |                                 |                                      */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/


data sd1.df1;
input name$;
cards4;
jane
mary
mike
;;;;
run;quit;

data sd1.df2;
input name$ day$ break lunch dinner;
cards4;
jane Mon 11 13 15
jane Tue 10 11 11
jane Wed 13 15 11
jane Thu 15 13 10
jane Fri 10 15 15
jane Sat 14 13 12
jane Sun 13 13 13
mary Mon 15 10 12
mary Tue 14 13 14
mary Wed 15 10 13
mary Thu 13 15 13
mary Fri 14 10 15
mary Sat 12 12 13
mary Sun 11 13 11
mike Mon 10 10 11
mike Tue 15 14 11
mike Wed 13 15 12
mike Thu 11 11 15
mike Fri 15 12 15
mike Sat 10 10 10
mike Sun 10 15 10
;;;;
run;quit;


%utl_rbeginx;
parmcards4;
library(haven)
library(dplyr)
source("c:/oto/fn_tosas9x.R")
df2<-read_sas("d:/sd1/df2.sas7bdat")
df1<-read_sas("d:/sd1/df1.sas7bdat")
df1
df2
result_df <-  df2 %>%  group_by(NAME) %>%
  summarize(mean_breakfast = mean(BREAK)
           ,mean_lunch     = mean(LUNCH)
           ,mean_dinner    = mean(DINNER)) %>%
  inner_join(df1, by = c("NAME"))
result_df
fn_tosas9x(
      inp    = result_df
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* SD1.DF1    SD1.DF2                                                                                                     */
/*                                                                                                                        */
/*   NAME     NAME    DAY    BREAK    LUNCH    DINNER                                                                     */
/*                                                                                                                        */
/*   jane     jane    Mon      11       13       15                                                                       */
/*   mary     jane    Tue      10       11       11                                                                       */
/*   mike     jane    Wed      13       15       11                                                                       */
/*            jane    Thu      15       13       10                                                                       */
/*            jane    Fri      10       15       15                                                                       */
/*            jane    Sat      14       13       12                                                                       */
/*            jane    Sun      13       13       13                                                                       */
/*            mary    Mon      15       10       12                                                                       */
/*            mary    Tue      14       13       14                                                                       */
/*            mary    Wed      15       10       13                                                                       */
/*            mary    Thu      13       15       13                                                                       */
/*            mary    Fri      14       10       15                                                                       */
/*            mary    Sat      12       12       13                                                                       */
/*            mary    Sun      11       13       11                                                                       */
/*            mike    Mon      10       10       11                                                                       */
/*            mike    Tue      15       14       11                                                                       */
/*            mike    Wed      13       15       12                                                                       */
/*            mike    Thu      11       11       15                                                                       */
/*            mike    Fri      15       12       15                                                                       */
/*            mike    Sat      10       10       10                                                                       */
/*            mike    Sun      10       15       10                                                                       */
/*                                                                                                                        */
/*                                                                                                                        */
/* d:/xls/wantxl.xlsx sheet DF1    d:/xls/wantxl.xlsx sheet DF2                                                           */
/*                                                                                                                        */
/* -----------------------+        --------------------+                                                                  */
/* | A1  | fx    | NAME   |        | A1  | fx    | NAME|                                                                  */
/* ------------------------        ------------------------------------------                                             */
/* [_]|    A     |                 [_]|    A     |   B |   C  |    E |    F |                                             */
/* ---------------                 ------------------------------------------                                             */
/*  1 | NAME     |                  1 | NAME     |  DAY| BREAK|LUNCHT|DINNER|                                             */
/* -- |----------+                 -- |----------+------+-----+------+------+                                             */
/*  2 | jane     |                  2 | jane     |Mon   |11   |13    |15    |                                             */
/* -- |----------+                 -- |----------+------+-----+------+------+                                             */
/*  3 | mary     |                  3 | jane     |Tue   |10   |11    |11    |                                             */
/* -- |----------+                 -- |----------+------+-----+------+------+                                             */
/*  4 | mike     |                  4 | jane     |Wed   |13   |15    |11    |                                             */
/* -- |----------+                 -- |----------+------+-----+------+------+                                             */
/*  5 | jane     |                  5 | jane     |Thu   |15   |13    |10    |                                             */
/* -- |----------+                 -- |----------+------+-----+------+------+                                             */
/*  6 | jane     |                  6 | jane     |Fri   |10   |15    |15    |                                             */
/* -- |----------+                 -- |----------+------+-----+------+------+                                             */
/* ,, | ...      |                 ,, | ...      |...   |...  |...   |...   |                                             */
/* -- |----------+                 -- |----------+------+-----+------+------+                                             */
/*                                 [DF2]                                                                                  */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                     _             _
/ |   _____  _____ ___| |  ___  __ _| |
| |  / _ \ \/ / __/ _ \ | / __|/ _` | |
| | |  __/>  < (_|  __/ | \__ \ (_| | |
|_|  \___/_/\_\___\___|_| |___/\__, |_|
                                  |_|
*/

%utl_rbeginx;
parmcards4;
library(haven)
library(dplyr)
source("c:/oto/fn_tosas9x.R")
df2<-read_sas("d:/sd1/df2.sas7bdat")
df1<-read_sas("d:/sd1/df1.sas7bdat")
df1
df2
result_df <-  df2 %>%  group_by(NAME) %>%
  summarize(mean_breakfast = mean(BREAK)
           ,mean_lunch     = mean(LUNCH)
           ,mean_dinner    = mean(DINNER)) %>%
  inner_join(df1, by = c("NAME"))
result_df
fn_tosas9x(
      inp    = result_df
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*                                                RESULTING WORKBOOK                                                      */
/*                                                                                                                        */
/*------------------------------------------------------------------------------------------------------------------------*/
/*                                                                       |                                                */
/*                            INPUT SHEETS                               |               OUTPUT SHEET                     */
/*  ==================================================================   |       =============================            */
/*                                                                       |                                                */
/*  d:/xls/wantxl.xlsx sheet DF1  d:/xls/wantxl.xlsx sheet DF2           | d:/xls/wantxl.xlsx sheet WANT                  */
/*                                                                       |                                                */
/*  -----------------------+      ----------------+                      | -----------------------+                       */
/*  | A1  | fx    | NAME   |      | A1  | fx| NAME|                      | | A1  | fx    | NAME   |                       */
/*  ------------------------      -------------------------------------- | ---------------------------------------------  */
/*  [_]|    A     |               [_]|    A |   B |   C  |    E |    F | | [_]|    A     |    B    |    C    |    E    |  */
/*  ---------------               -------------------------------------- | ---------------------------------------------  */
/*   1 | NAME     |                1 | NAME |  DAY| BREAK|LUNCHT|DINNER| |  1 | NAME     |AVGBREAK |AVGLUNCHT|AVGDINNER|  */
/*  -- |----------+               -- |------+------+-----+------+------+ | -- |----------+---------+---------+---------+  */
/*   2 | jane     |                2 | jane |Mon   |11   |13    |15    | |  2 | jane     |12.29    |13.29    |12.43    |  */
/*  -- |----------+               -- |------+------+-----+------+------+ | -- |----------+---------+---------+---------+  */
/*   3 | mary     |                3 | jane |Tue   |10   |11    |11    | |  3 | mary     |13.43    |11.86    |13.00    |  */
/*  -- |----------+               -- |------+------+-----+------+------+ | -- |----------+---------+---------+---------+  */
/*   4 | mike     |                4 | jane |Wed   |13   |15    |11    | |  4 | mike     |12.00    |12.43    |12.00    |  */
/*  -- |----------+               -- |------+------+-----+------+------+ | -- |----------+---------+---------+---------+  */
/*   5 | jane     |                5 | jane |Thu   |15   |13    |10    | | [WANT}                                         */
/*  -- |----------+               -- |------+------+-----+------+------+ |                                                */
/*   6 | jane     |                6 | jane |Fri   |10   |15    |15    | |                                                */
/*  -- |----------+               -- |------+------+-----+------+------+ |                                                */
/*  ,, | ...      |               ,, | ...  |...   |...  |...   |...   | |                                                */
/*  -- |----------+               -- |------+------+-----+------+------+ |                                                */
/*                                [DF2]                                  |                                                */
/*                                                                       |                                                */
/**************************************************************************************************************************/

/*
 ____                                       _   _
|___ \   ___  __ _ ___   _ __   _ __  _   _| |_| |__   ___  _ __
  __) | / __|/ _` / __| | `__| | `_ \| | | | __| `_ \ / _ \| `_ \
 / __/  \__ \ (_| \__ \ | |    | |_) | |_| | |_| | | | (_) | | | |
|_____| |___/\__,_|___/ |_|    | .__/ \__, |\__|_| |_|\___/|_| |_|
                               |_|    |___/
*/

 https://tinyurl.com/3kww82ch

/*____   _
|___ /  | |__   __ _ ___  ___   _ __
  |_ \  | `_ \ / _` / __|/ _ \ | `__|
 ___) | | |_) | (_| \__ \  __/ | |
|____/  |_.__/ \__,_|___/\___| |_|

*/

%utl_rbeginx;
parmcards4;
library(haven)
library(dplyr)
source("c:/oto/fn_tosas9x.R")
df2<-read_sas("d:/sd1/df2.sas7bdat")
df1<-read_sas("d:/sd1/df1.sas7bdat")
want<-
 df2 %>% group_by(NAME) %>%
 summarize(avgbreak=mean(BREAK)
  ,avglunch=mean(LUNCH)
  ,avgdinner=mean(DINNER)) %>%
  inner_join(df1,by=c("NAME"))
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/*                                               |                                                                        */
/*  NAME  avgbreak avglunch avgdinner  ROWNAMES  |  NAME    AVGBREAK    AVGLUNCH    AVGDINNER                             */
/*                                               |                                                                        */
/*  jane      12.3     13.3      12.4      1     |  jane     12.2857     13.2857     12.4286                              */
/*  mary      13.4     11.9      13        2     |  mary     13.4286     11.8571     13.0000                              */
/*  mike      12       12.4      12        3     |  mike     12.0000     12.4286     12.0000                              */
/*                                               |                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
