SELECT *
FROM
  (SELECT trim(regexp_substr(tb2.vals,'[^:]+',1,1)) field ,
    trim(regexp_substr(tb2.vals,'[^:]+',1,2)) val
  FROM
    ( WITH tb AS
    (SELECT regexp_replace(REPLACE(API_RESPONSE,'"data":'),'[{}"]') pairs
    FROM useragent_lookup
    )
  SELECT trim(regexp_substr(tb.pairs,'[^,]+',1, level)) vals
  FROM tb
    CONNECT BY regexp_substr(tb.pairs,'[^,]+',1, level) IS NOT NULL
    ) tb2
  ) 
pivot 
( MIN(val) 
  FOR field IN ('ua_type' as ua_type
              ,'ua_brand' as ua_brand
              ,'ua_name' as ua_name
              ,'ua_version' as ua_version
              ,'ua_url' as ua_url
              ,'os_name' as os_name
              ,'os_version' as os_version
              ,'browser_name' as browser_name
              ,'browser_version' as browser_version
              ,'engine_name' as engine_name
              ,'engine_version' as engine_version
 ) 
);