/*******************************p_moniCombo Procedure*******************************/
CREATE procedure p_moniCombo(
    @step varchar(5),
    @fullstr  varchar(max)
)
as

declare @strArray varchar(max);
declare @query varchar(max);

set @query = 'WITH PARAM(POS , VAL1) AS( SELECT POS , VAL1 FROM FN_SPLIT('''+@fullstr+''' , '','' ) )';
IF (@step = 'mo')
	set @query = @query+'SELECT MDL_CD AS CODE  , MDL_CD  AS CODE_NM
	   FROM CIS_BOM WITH(NOLOCK)  
      GROUP BY MDL_CD'
ELSE IF (@step = 'wb')
	 set @query = @query+'SELECT A.WB_CD AS CODE, B.WB_NM AS CODE_NM
	  FROM CIS_BOM A WITH(NOLOCK)  INNER JOIN CIS_WB B WITH(NOLOCK) ON A.WB_CD = B.WB_CD 
	 WHERE A.MDL_CD = (select VAL1 from param where POS = 1)
	GROUP BY A.WB_CD,B.WB_NM' 
ELSE IF (@step = 'wc') 
	 set @query = @query+'SELECT A.WC_CD AS CODE, B.WC_NM AS CODE_NM
	   FROM CIS_BOM A WITH(NOLOCK) INNER JOIN CIS_WC B WITH(NOLOCK) ON A.WB_CD = B.WB_CD  AND  A.WC_CD = B.WC_CD 
	  WHERE A.MDL_CD = (select VAL1 from param where POS = 1)
	   	AND A.WB_CD  = (select VAL1 from param where POS = 2)
		GROUP BY  A.WC_CD,B.WC_NM'
ELSE IF (@step = 'rp')
	set @query = @query+'SELECT B.RPT_CD AS CODE ,MAX(B.RPT_NM) AS CODE_NM  
	    FROM [dbo].CIS_WC_WRK A WITH(NOLOCK) INNER JOIN  
	     CIS_RPT B WITH(NOLOCK) ON A.WRK_CD = B.WRK_CD
	   WHERE 1=1
	     AND A.USE_YN = ''Y''
	 AND B.USE_YN = ''Y''
	 AND WRK_DIV = ''C''
	 AND MDL_CD   = (select VAL1 from param where POS = 1)
	 AND WB_CD   = (select VAL1 from param where POS = 2)
	 AND WC_CD   =  (select VAL1 from param where POS = 3)
	  GROUP BY B.RPT_CD' 
	 
execute(@query)	 
/*******************************p_moniCombo Procedure*******************************/    

/*******************************FN_SPLIT Function*******************************/    
CREATE FUNCTION [dbo].[FN_SPLIT] (
@strList VARCHAR(MAX) ,
@pats VARCHAR(10) ) RETURNS @TB TABLE ( POS int IDENTITY PRIMARY KEY,
VAL1 varchar(200) ) AS
BEGIN DECLARE @startIndex SMALLINT ,
@lastIndex SMALLINT ,
@cnt SMALLINT ,
@patsSize SMALLINT
SELECT
	@patsSize = LEN(@pats) IF RIGHT(@strList,
	@patsSize)!= @pats BEGIN SET
	@strList = @strList + @pats END SET
	@strList = @pats + @strList SET
	@startIndex = 1
SELECT
	@lastIndex = CHARINDEX (@pats,
	@strList ,
	@startIndex + @patsSize) SET
	@cnt = 0 WHILE (1 = 1) BEGIN SET
	@startIndex = CHARINDEX (@pats,
	@strList )
SELECT
	@lastIndex = CHARINDEX (@pats,
	@strList ,
	@startIndex + @patsSize) IF @lastIndex <= 0 BREAK
INSERT
	INTO
	@TB(VAL1)
VALUES (SUBSTRING(@strList, @startIndex + @patsSize, @lastIndex-@startIndex-@patsSize))
SELECT
	@strList = STUFF(@strList,
	@startIndex,
	@patsSize,
	'') SET
	@cnt = @cnt + 1 END RETURN END
/*******************************FN_SPLIT Function*******************************/    