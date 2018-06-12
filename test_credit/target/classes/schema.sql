CREATE TABLE creditcard (
  id INT AUTO_INCREMENT,
  name VARCHAR(100),
  PRIMARY KEY (id)
);

CREATE TABLE service (
  id INT AUTO_INCREMENT,
  content VARCHAR(100),
  PRIMARY KEY (id)
);

CREATE TABLE creditcard_service (
  creditcard_id INT,
  service_id INT,
  PRIMARY KEY (creditcard_id, service_id),
  FOREIGN KEY (creditcard_id) REFERENCES creditcard(id),
  FOREIGN KEY (service_id) REFERENCES service(id)
);

ALTER TABLE creditcard_service ADD score int;
UPDATE creditcard_service SET score = 1;

CREATE TABLE creditcard_service_user (
  creditcard_id INT,
  service_id INT,
/*
  PRIMARY KEY (creditcard_id, service_id),
  FOREIGN KEY (creditcard_id) REFERENCES creditcard_service(creditcard_id),
  FOREIGN KEY (service_id) REFERENCES creditcard_service(service_id)
*/
);

INSERT INTO creditcard (id, name) VALUES 
	(01, 'Orico Card THE POINT'), (02, '楽天カード'), (03, '三井住友VISAゴールドカード'), (04, 'エポスカード'), (05, 'Yahoo! JAPANカード');
/*
INSERT INTO creditcard (id, name) VALUES 
	(01, 'Orico Card THE POINT'), (02, '楽天カード'), (03, '三井住友VISAゴールドカード'), (04, 'エポスカード'), (05, 'Yahoo! JAPANカード'),
	(06, '三井住友VISAクラシックカード'), (07, 'Orico Card THE POINT PREMIUM GOLD'), (08, 'dカード GOLD'), (09, 'イオンカードセレクト'), 
	(10, 'JCB CARD W'), (11, 'レックスカード'), (12, 'ビックカメラSuicaカード'), (13, '楽天ゴールドカード'), (14, 'リクルートカード'), 
	(15, 'イオンカード（WAON一体型）'), (16, 'イオンSuicaカード'), (17, 'dカード'), (18, 'アメリカン・エキスプレス・ゴールド・カード'),
	(19, '三菱UFJニコス VIASOカード'), (20, '「ビュー・スイカ」カード');
*/

INSERT INTO service (id, content) VALUES 
	(01, '入会キャンペーン実施中'), (02, 'ポイント還元率が高い'), (03, 'ネットショッピングでお得(Amazon.co.jp)'), (04, 'ネットショッピングでお得(Yahoo!ショッピング)'), 
	(05, 'ネットショッピングでお得(楽天市場)');	
/*
INSERT INTO service (id, content) VALUES 
	(01, '入会キャンペーン実施中'), (02, 'ポイント還元率が高い'), (03, 'ネットショッピングでお得'), (04, '街なかのショッピングでお得'), (05, 'コンビニでお得'), 
	(06, 'スーパーでお得'), (07, 'カフェやレストランでお得'), (08, '携帯電話でお得'), (09, '電車でお得/便利'), (10, 'ガソリンスタンドでお得'), 
	(11, '健康相談サービス'), (12, 'ホテル予約サイトで割引あり'), (13, '空港ラウンジを利用できる'), (14, 'ANAマイルをためる'), (15, 'JALマイルをためる'), 
	(16, 'Apple Payに追加できる'), (17, '即日発行できる');
	
*/

INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (01, 01), (01, 02), (01, 03), (01, 04), (01, 05);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (02, 01), (02, 02), (02, 05);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (03, 01);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (04, 01);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (05, 01), (05, 02), (05, 04);

-- あるクレジットカードIDに関係のあるサービス一覧を取得し、その件数を返却する。
SELECT COUNT(*) FROM creditcard_service WHERE creditcard_id = 1;


SELECT
	ccs1.service_id, 
	ccs1.creditcard_id  AS creditcard1, 
	ccs2.creditcard_id  AS creditcard2 
FROM 
	creditcard_service AS ccs1 
	JOIN 
		creditcard_service AS ccs2 
		ON ccs1.service_id  = ccs2.service_id 
WHERE 
	ccs1.creditcard_id <>  ccs2.creditcard_id;


SELECT
	ccs1.creditcard_id  AS creditcard1, 
	ccs2.creditcard_id  AS creditcard2,
	COUNT(1) AS cnt 
FROM 
	creditcard_service AS ccs1 
	JOIN 
		creditcard_service AS ccs2 
		ON ccs1.service_id  = ccs2.service_id 
WHERE 
	ccs1.creditcard_id <>  ccs2.creditcard_id
GROUP BY
	ccs1.creditcard_id, ccs2.creditcard_id;


SELECT
	creditcard_id,
	SUM(score) AS sum,
	SQRT(SUM(score)) AS norm
FROM
	creditcard_service
GROUP BY creditcard_id;


SELECT
	service_id,
	creditcard_id,
	SQRT(SUM(score)) AS norm,
	score / SQRT(SUM(score)) AS nscore
FROM
	creditcard_service
GROUP BY creditcard_id, service_id;



/*
SELECT
	service_id,
	creditcard_id,
	SQRT(SUM(score) OVER(PARTITION BY creditcard_id)) AS norm,
	score / SQRT(SUM(score) OVER(PARTITION BY creditcard_id)) AS nscore
FROM
	creditcard_service;





WITH
	norm_creditcard_service AS (
		SELECT service_id, creditcard_id,
			score / SQRT(SUM(score) OVER(PARTITION BY creditcard_id)) AS nscore
		FROM creditcard_service
	)
SELECT
	cs1.creditcard_id AS target,
	cs2.creditcard_id AS recommend,
	SUM(cs1.nscore * cs2.nscore) AS score
FROM
	norm_creditcard_service AS cs1
	JOIN
		norm_creditcard_service AS cs2
		ON cs1.service_id = cs2.service_id
	GROUP BY
		cs1.creditcard_id, cs2.creditcard_id; */





