<?php
	$flash_message = Session::instance()->get_once('flash_message');
	$type = isset($type) ? $type : 'info';
	if (!empty($flash_message)):
?>

	<div class="<?= $type ?> alert">
		<span><?= $flash_message ?></span>
	</div>

<?php endif?>