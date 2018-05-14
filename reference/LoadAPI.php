<?php

/**
 * Created by PhpStorm.
 * User: jwc
 * Date: 5/19/2017
 * Time: 1:03 AM
 */
class LoadAPI
{
    protected $conn = null;
    protected $getStmt = null;
    protected $sql = null;

    protected $sqls = array(
        'fundflow' => array(
            "CREATE TEMPORARY TABLE IF NOT EXISTS fundflows_tmp (LIKE api.fundflows);",
            "TRUNCATE fundflows_tmp;",
            "COPY fundflows_tmp FROM '/tmp/fundflow.csv' DELIMITER ',' CSV ENCODING 'windows-1251';",
            "DELETE FROM api.fundflows WHERE run_date IN (SELECT DISTINCT run_date FROM fundflows_tmp);",
            "INSERT INTO api.fundflows (SELECT * FROM fundflows_tmp);"
        ),
        'analytics' => array(
            "CREATE TEMPORARY TABLE IF NOT EXISTS analytics_tmp (LIKE api.analytics);",
            "TRUNCATE analytics_tmp;",
            "COPY analytics_tmp FROM '/tmp/analytics.csv' DELIMITER ',' CSV ENCODING 'windows-1251';",
            "DELETE FROM api.analytics WHERE run_date IN (SELECT DISTINCT run_date FROM analytics_tmp);",
            "INSERT INTO api.analytics (SELECT * FROM analytics_tmp);",
        ),
        'industry' => array(
            "CREATE TEMPORARY TABLE IF NOT EXISTS industry_tmp (LIKE api.industry) ;",
            "TRUNCATE industry_tmp;",
            "COPY industry_tmp FROM '/tmp/industry.csv' DELIMITER E'\t' CSV ENCODING 'windows-1251';",
            "DELETE FROM api.industry WHERE run_date IN (SELECT DISTINCT run_date FROM industry_tmp);",
            "INSERT INTO api.industry (SELECT * FROM industry_tmp);"
        ),
        'constituents' => array(
            "CREATE TEMPORARY TABLE IF NOT EXISTS constituents_tmp (LIKE api.constituents);",
            "TRUNCATE constituents_tmp;",
            "COPY constituents_tmp FROM '/tmp/constituents.csv' DELIMITER ',' CSV ENCODING 'windows-1251';",
            "DELETE FROM api.constituents WHERE run_date IN (SELECT DISTINCT run_date FROM constituents_tmp);",
            "INSERT INTO api.constituents (SELECT * FROM constituents_tmp);"
        )
    );

    protected $date_sqls = array(
        "SELECT 'industry', max(run_date) FROM api.industry",
        "SELECT 'constituents', max(run_date) FROM api.constituents",
        "SELECT 'fundflows', max(run_date) FROM api.fundflows",
        "SELECT 'analytics', max(run_date) FROM api.analytics"

    );

    public function __construct()
    {
        $dsn = "pgsql:host=localhost;port=5432;dbname=etfg;user=etfg;password=P@ssw0rd";
        $this->conn = new \PDO($dsn);
    }

    protected function run($stmt)
    {
        echo "SQL: $stmt\n";
        $rows = array();
        try {
            if ($rows = $this->conn->exec($stmt) === false) {
                echo "Failed.\n";
                var_dump($this->conn->errorInfo());
            }
        } catch (\Exception $exception) {
            echo $exception->getMessage();
        }
    }

    public function load()
    {
        foreach ($this->sqls as $name => $stmts) {
            echo "Loading: $name - " . date("Y-m-d H:i:s") . "\n";

            foreach ($stmts as $stmt) {
                $this->run($stmt);
            }
        }
    }

    public function check_dates()
    {
        foreach ($this->date_sqls as $date_sql) {
            foreach ($this->conn->query($date_sql) as $row) {
                echo "{$row[0]}: {$row[1]}\n";
            }
        }
    }

}

$db = new LoadAPI();
$db->load();
$db->check_dates();
