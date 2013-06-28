<!doctype html>
<html lang="<?php echo I18n::$lang ?>">
  <head>
    <meta charset="utf-8">
    <title><?php echo $title ?></title>
    <?= html::style("assets/css/kohana-scaffold.css"); ?>
    <?= html::style("assets/gumby/css/gumby.css"); ?>
  </head>

  <body>
    <nav class="navbar">
      <article class="row">
        <ul class="one">
          <li><?= html::anchor('welcome', 'Home') ?></li>
        </ul>
      </article>
    </nav>
    <article class="container">
      <section class="row">
        <?= $content ?>
      </section>
    </article>
  </body>
</html>
