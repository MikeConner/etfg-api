<?php
/**
 * Created by PhpStorm.
 * User: jwc
 * Date: 3/2/2017
 * Time: 9:56 PM
 */
use \Phalcon\Mvc\Model as Model;

class Customer extends Model
{
    private static $permissions = [
        'koyfin' => [
            'api' => [
                'industry' => true,
                'analytics' => false,
                'fundflow' => true,
                'constituents' => true
            ]
        ],
    ];

    public static function hasPermission($username, $module, $permission)
    {

        error_log(sprintf("%s\t$username\t$module\t$permission\n",
            date('Y-m-d H:i:s')),
            3,
            '/tmp/user.log');

            //'/var/log/httpd/user.log');
        if (isset(Customer::$permissions[$username][$module][$permission]))
            return Customer::$permissions[$username][$module][$permission];
        return false;
    }
}
