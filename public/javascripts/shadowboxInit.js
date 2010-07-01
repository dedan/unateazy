Event.observe(document, "dom:loaded", init);
Shadowbox.loadLanguage('en', '/javascripts');
Shadowbox.loadPlayer(['img'], '/javascripts');
Shadowbox.loadSkin('classic', '/javascripts/skin'); // use the "classic" skin

function init()
{
	var options = {
		animate:     false,
		overlayOpacity: 0.7,
        handleOversize: 'scroll'
	};
	Shadowbox.init(options);
};

