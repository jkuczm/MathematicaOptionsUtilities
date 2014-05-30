(* Mathematica Test File *)

(* ::Section:: *)
(*SetUp*)


Begin["TestEnvironment`Acceptance`DelegateOptions`"];


(* Define options for "base" function. *)
Options[f] = {
	"opt1" -> "opt1ValueDefaultf",
	"opt2" -> "opt2ValueDefaultf",
	"opt3" -> "opt3ValueDefaultf"
};


(* Define "base" function. *)
f[OptionsPattern[]] := {
	OptionValue["opt1"],
	OptionValue["opt2"],
	OptionValue["opt3"]
};


(* Define options for "inheriting" function. *)
Options[g] = {
	"opt1" -> "opt1ValueDefaultg",
	"opt2" -> "opt2ValueDefaultg",
	"opt4" -> "opt4ValueDefaultg"
};


(* Define "inheriting" function. *)
g[opts:OptionsPattern[]] :=
	Append[f[DelegateOptions[opts, g, f]], OptionValue["opt4"]];


(* ::Section:: *)
(*Tests*)


(* ::Subsection:: *)
(*Before default option changes*)


BeginTestSection["Before default option changes"]

Test[
	g[]
	,
	{
		"opt1ValueDefaultg", "opt2ValueDefaultg",
		"opt3ValueDefaultf", "opt4ValueDefaultg"
	}
	,
	TestID -> "Before default option changes: \
without explicit options"
];
Test[
	g["opt1" -> "opt1ValueExplicit"]
	,
	{
		"opt1ValueExplicit", "opt2ValueDefaultg",
		"opt3ValueDefaultf", "opt4ValueDefaultg"
	}
	,
	TestID -> "Before default option changes: \
explicit \"opt1\" value"
];
Test[
	g[
		"opt2" -> "opt2ValueExplicit",
		{"opt4" -> "opt4ValueExplicit", "opt1" -> "opt1ValueExplicit"}
	]
	,
	{
		"opt1ValueExplicit", "opt2ValueExplicit",
		"opt3ValueDefaultf", "opt4ValueExplicit"
	}
	,
	TestID -> "Before default option changes: \
explicit \"opt1,2,4\" values"
];

EndTestSection[]


(* Change default option of "base" function. *)
SetOptions[
	f,
	"opt1" -> "opt1ValueDefaultSetInf",
	"opt3" -> "opt3ValueDefaultSetInf"
]


(* ::Subsection:: *)
(*After change of default options for \"base\" function*)


BeginTestSection["After change of default options for \"base\" function"]

Test[
	g[]
	,
	{
		"opt1ValueDefaultg", "opt2ValueDefaultg",
		"opt3ValueDefaultSetInf", "opt4ValueDefaultg"
	}
	,
	TestID -> "After change of default options for \"base\" function: \
without explicit options"
];
Test[
	g["opt1" -> "opt1ValueExplicit"]
	,
	{
		"opt1ValueExplicit", "opt2ValueDefaultg",
		"opt3ValueDefaultSetInf", "opt4ValueDefaultg"
	}
	,
	TestID -> "After change of default options for \"base\" function: \
explicit \"opt1\" value"
];
Test[
	g[
		"opt2" -> "opt2ValueExplicit",
		{"opt4" -> "opt4ValueExplicit", "opt1" -> "opt1ValueExplicit"}
	]
	,
	{
		"opt1ValueExplicit", "opt2ValueExplicit",
		"opt3ValueDefaultSetInf", "opt4ValueExplicit"
	}
	,
	TestID -> "After change of default options for \"base\" function: \
explicit \"opt1,2,4\" values"
];

EndTestSection[]


(* Change default option of "inheriting" function. *)
SetOptions[
	g,
	"opt1" -> "opt1ValueDefaultSetIng",
	"opt4" -> "opt4ValueDefaultSetIng"
]


(* ::Subsection:: *)
(*After change of default options for \"inheriting\" function*)


BeginTestSection["After change of default options for \"inheriting\" function"]

Test[
	g[]
	,
	{
		"opt1ValueDefaultSetIng", "opt2ValueDefaultg",
		"opt3ValueDefaultSetInf", "opt4ValueDefaultSetIng"
	}
	,
	TestID -> "After change of default options for \"inheriting\" function: \
without explicit options"
];
Test[
	g["opt1" -> "opt1ValueExplicit"]
	,
	{
		"opt1ValueExplicit", "opt2ValueDefaultg",
		"opt3ValueDefaultSetInf", "opt4ValueDefaultSetIng"
	}
	,
	TestID -> "After change of default options for \"inheriting\" function: \
explicit \"opt1\" value"
];
Test[
	g[
		"opt2" -> "opt2ValueExplicit",
		{"opt4" -> "opt4ValueExplicit", "opt1" -> "opt1ValueExplicit"}
	]
	,
	{
		"opt1ValueExplicit", "opt2ValueExplicit",
		"opt3ValueDefaultSetInf", "opt4ValueExplicit"
	}
	,
	TestID -> "After change of default options for \"inheriting\" function: \
explicit \"opt1,2,4\" values"
];

EndTestSection[]


(* ::Section:: *)
(*TearDown*)


(* Remove all symbols defined in current context. *)
Unprotect["`*"];
Quiet[Remove["`*"], {Remove::rmnsm}];


End[];
