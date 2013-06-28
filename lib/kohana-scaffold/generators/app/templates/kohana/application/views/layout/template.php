<!doctype html>
<html lang="<?php echo I18n::$lang ?>">
  <head>
    <meta charset="utf-8">
    <title><?php echo $title ?></title>
    <?php echo html::style("assets/gumby/css/style.css"); ?>
    <?php echo html::style("assets/gumby/css/gumby.css"); ?>
  </head>

  <body>
    <div class="navbar">
      <div class="row">
        <ul class="one">
          <li><?php echo html::anchor('welcome/index', 'Home') ?></li>
        </ul>
      </div>
    </div>
    <div class="container">
      <div class="row">
        <?php echo $content ?>
      </div>
    </div>
  </body>
</html>
