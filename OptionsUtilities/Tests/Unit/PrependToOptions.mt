(* Mathematica Test File *)

(* ::Section:: *)
(*SetUp*)


Begin["TestEnvironment`PrependToOptions`"];


baseOptions = {
	"opt1" -> "opt1ValBase",
	"opt2" -> "opt2ValBase"
};


(* ::Section:: *)
(*Tests*)


Module[
	{
		f,
		newOptions = {
			"opt3" -> "opt3ValNew",
			"opt1" -> "opt1ValBase",
			"opt2" -> "opt2ValBase"
		}
	}
	,
	Options[f] = baseOptions;
	
	Test[
		PrependToOptions[f, "opt3" -> "opt3ValNew"]
		,
		newOptions
		,
		TestID -> "one new option: \
PrependToOptions evaluation"
	];
	Test[
		Options[f]
		,
		newOptions
		,
		TestID -> "one new option: \
Options"
	];
];


Module[
	{
		f,
		newOptions = {
			"opt3" -> "opt3ValNew",
			"opt4" -> "opt4ValNew",
			"opt1" -> "opt1ValBase",
			"opt2" -> "opt2ValBase"
		}
	}
	,
	Options[f] = baseOptions;
	
	Test[
		PrependToOptions[f, "opt3" -> "opt3ValNew", "opt4" -> "opt4ValNew"]
		,
		newOptions
		,
		TestID -> "two new options: \
PrependToOptions evaluation"
	];
	Test[
		Options[f]
		,
		newOptions
		,
		TestID -> "two new options: \
Options"
	];
];


Module[
	{
		f,
		newOptions = {
			"opt3" -> "opt3ValNew",
			"opt4" -> "opt4ValNew",
			"opt5" -> "opt5ValNew",
			"opt1" -> "opt1ValBase",
			"opt2" -> "opt2ValBase"
		}
	}
	,
	Options[f] = baseOptions;
	
	Test[
		PrependToOptions[
			f,
			{
				"opt3" -> "opt3ValNew",
				{"opt4" -> "opt4ValNew", "opt5" -> "opt5ValNew"}
			}
		]
		,
		newOptions
		,
		TestID -> "three new options, complicated sequence: \
PrependToOptions evaluation"
	];
	Test[
		Options[f]
		,
		newOptions
		,
		TestID -> "three new options, complicated sequence: \
Options"
	];
];


Module[
	{
		f,
		newOptions = {
			"opt1" -> "opt1ValNew",
			"opt2" -> "opt2ValBase"
		}
	}
	,
	Options[f] = baseOptions;
	
	Test[
		PrependToOptions[f, "opt1" -> "opt1ValNew"]
		,
		newOptions
		,
		TestID -> "one old option with new value: \
PrependToOptions evaluation"
	];
	Test[
		Options[f]
		,
		newOptions
		,
		TestID -> "one old option with new value: \
Options"
	];
];


Module[
	{
		f,
		newOptions = {
			"opt1" -> "opt1ValNew",
			"opt1" -> "opt1ValBase",
			"opt2" -> "opt2ValBase"
		}
	}
	,
	Options[f] = baseOptions;
	
	Test[
		PrependToOptions[
			f, {"opt1" -> "opt1ValNew"},
			"DeleteOptionDuplicates" -> False
		]
		,
		newOptions
		,
		TestID -> "one old option with new value, \
\"DeleteOptionDuplicates\" -> False: \
PrependToOptions evaluation"
	];
	Test[
		Options[f]
		,
		newOptions
		,
		TestID -> "one old option with new value, \
\"DeleteOptionDuplicates\" -> False: \
Options"
	];
];


(* ::Section:: *)
(*TearDown*)


(* Remove all symbols defined in current context. *)
Unprotect["`*"];
Quiet[Remove["`*"], {Remove::rmnsm}];


End[];
