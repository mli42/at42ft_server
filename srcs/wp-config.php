<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'database' );

/** MySQL database username */
define( 'DB_USER', 'mli' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',			'Lhf|:=R+G+xHyf1/5R1`?l2xv3~^+/;_1GL+[`_&1%;a:H+F|ePSMrE|8I~kv*+~');
define('SECURE_AUTH_KEY',	'Y1_wa|y{(h]loE]<;:CUF90^&+3Ntc[ITqAC1=1--9(P$-Lmz9[D+?-f;v&jD7+(');
define('LOGGED_IN_KEY',		'6#vR;}7@gk;ktUG{Rtli+xxv-#d`$lsDYSK9J=>.w,hQ&Xf^FL3X%~AHd}LM[p2a');
define('NONCE_KEY',			'd-B+bY#([`[&)>t#k(I*CJRTBz_GapU7/czlGlpuc+|)^V.<*%YnJlrwYF8M9K-&');
define('AUTH_SALT',			'Msjz%uVKTU;EMHuJrQf!p`lS`}YoL@Na+6EQS!nUlt$hiyJ4u8Z)GCbs!-dW[U=v');
define('SECURE_AUTH_SALT',	'5r!,b.-<^>Nh{n*nK+kt=ca#+hhXRu OkAu]m5om0 ReYQsl^K:-}]d;+7qZ (LB');
define('LOGGED_IN_SALT',	'U6:r-;I#oEj{n[QR?+>`*(l8ss%QQEn4Y>hN=^iY;cNmOkz),.(#iT{F64Xa(NE[');
define('NONCE_SALT',		'0XK.3HfGbXtVWKQ2-L~iF)K*$.(l.(RDu/+Go-+U7]RM`O8GN),:n3)~%ZwDAJ|Y');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
