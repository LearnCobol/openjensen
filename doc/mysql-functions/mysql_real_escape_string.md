## mysql_real_escape_string

mysql_real_escape_string — Escapes special characters in a string for
                           use in an SQL statement


### Description

```php
string mysql_real_escape_string ( string $unescaped_string
                    [, resource $link_identifier = NULL ] )
``` 
 
Escapes special characters in the unescaped_string, taking into account the
current character set of the connection so that it is safe to place it in
a mysql_query(). If binary data is to be inserted, this function must be used.

mysql_real_escape_string() calls MySQL's library function
mysql_real_escape_string, which prepends backslashes to the following
characters: \x00, \n, \r, \, ', " and \x1a.

This function must always (with few exceptions) be used to make data safe
before sending a query to MySQL.

**Caution**

Security: the default character set

The character set must be set either at the server level, or with the API
function mysql_set_charset() for it to affect mysql_real_escape_string().
See the concepts section on character sets for more information.

### Parameters

*unescaped_string*

    The string that is to be escaped.
    
*link_identifier*

    The MySQL connection. If the link identifier is not specified, the last
    link opened by mysql_connect() is assumed. If no such link is found, it
    will try to create one as if mysql_connect() was called with no arguments.
    If no connection is found or established,
    an E_WARNING level error is generated.

### Return Values

Returns the escaped string, or FALSE on error.

### Examples

Example #1 Simple mysql_real_escape_string() example

```php
<?php
// Connect
$link = mysql_connect('mysql_host', 'mysql_user', 'mysql_password')
    OR die(mysql_error());

// Query
$query = sprintf("SELECT * FROM users WHERE user='%s' AND password='%s'",
            mysql_real_escape_string($user),
            mysql_real_escape_string($password));
?>
```

Example #2 An example SQL Injection Attack

```php
<?php
// We didn't check $_POST['password'], it could be anything
// the user wanted! For example:
$_POST['username'] = 'aidan';
$_POST['password'] = "' OR ''='";

// Query database to check if there are any matching users
$query = "SELECT * FROM users WHERE user='{$_POST['username']}'
                                AND password='{$_POST['password']}'";
mysql_query($query);

// This means the query sent to MySQL would be:
echo $query;
?>
```

The query sent to MySQL:

```php
SELECT * FROM users WHERE user='aidan' AND password='' OR ''=''
```

This would allow anyone to log in without a valid password.


### Notes

    Note:

    A MySQL connection is required before using mysql_real_escape_string()
    otherwise an error of level E_WARNING is generated, and FALSE is returned.
    If link_identifier isn't defined, the last MySQL connection is used.

    Note:

    If magic_quotes_gpc is enabled, first apply stripslashes() to the data.
    Using this function on data which has already been escaped will escape
    the data twice.

    Note:

    If this function is not used to escape data, the query is vulnerable
    to SQL Injection Attacks.

    Note: mysql_real_escape_string() does not escape % and _.
    These are wildcards in MySQL if combined with LIKE, GRANT, or REVOKE. 


### References

[PHP manual: mysql_real_escape_string](http://www.php.net/manual/en/function.mysql-real-escape-string.php)

Copyright © 2001-2014 The PHP Group