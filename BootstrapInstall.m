(* ::Package:: *)

Get["https://raw.githubusercontent.com/jkuczm/MathematicaBootstrapInstaller/v0.1.1/BootstrapInstaller.m"]


BootstrapInstall[
	"OptionsUtilities",
	"https://github.com/jkuczm/MathematicaOptionsUtilities/releases/download/v0.1.0/OptionsUtilities.zip",
	"AdditionalFailureMessage" ->
		Sequence[
			"You can ",
			Hyperlink[
				"install OptionsUtilities package manually",
				"https://github.com/jkuczm/MathematicaOptionsUtilities#manual-installation"
			],
			"."
		]
]
