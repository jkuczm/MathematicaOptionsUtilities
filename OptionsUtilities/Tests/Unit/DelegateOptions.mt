(* Mathematica Test File *)

(* ::Section:: *)
(*SetUp*)


Begin["TestEnvironment`DelegateOptions`"];


(* Mock options. *)
Options[f] = {
	"opt1" -> "opt1Valuef",
	"opt2" -> "opt2Valuef"
};
Options[g] = {
	"opt1" -> "opt1Valueg",
	"opt2" -> "opt2Valueg",
	"opt3" -> "opt3Valueg"
}
Options[h] = {
	"opt1" -> "opt1Valueh",
	"opt4" -> "opt4Valueh"
}


(* ::Section:: *)
(*Tests*)


(* ::Subsection:: *)
(*no explicit option*)


BeginTestSection["no explicit option"]

Test[
	DelegateOptions[g, f]
	,
	{
		"opt1" -> "opt1Valueg",
		"opt2" -> "opt2Valueg"
	}
	,
	TestID -> "no explicit option, superset -> subset"
];
Test[
	DelegateOptions[f, g]
	,
	{
		"opt1" -> "opt1Valuef",
		"opt2" -> "opt2Valuef"
	}
	,
	TestID -> "no explicit option, subset -> superset"
];
Test[
	DelegateOptions[f, h]
	,
	{
		"opt1" -> "opt1Valuef"
	}
	,
	TestID -> "no explicit option, between intersecting"
];

EndTestSection[]


(* ::Subsection:: *)
(*explicit unrealted option*)


BeginTestSection["explicit unrealted option"]

Test[
	DelegateOptions["optUnrelated" -> "optUnrelatedValue", g, f]
	,
	{
		"opt1" -> "opt1Valueg",
		"opt2" -> "opt2Valueg"
	}
	,
	TestID -> "explicit unrealted option, superset -> subset"
];
Test[
	DelegateOptions["optUnrelated" -> "optUnrelatedValue", f, g]
	,
	{
		"opt1" -> "opt1Valuef",
		"opt2" -> "opt2Valuef"
	}
	,
	TestID -> "explicit unrealted option, subset -> superset"
];
Test[
	DelegateOptions["optUnrelated" -> "optUnrelatedValue", f, h]
	,
	{
		"opt1" -> "opt1Valuef"
	}
	,
	TestID -> "explicit unrealted option, between intersecting"
];

EndTestSection[]


(* ::Subsection:: *)
(*explicit option present in both*)


BeginTestSection["explicit option present in both"]

Test[
	DelegateOptions["opt1" -> "opt1ValueExplicit", g, f]
	,
	{
		"opt1" -> "opt1ValueExplicit",
		"opt2" -> "opt2Valueg"
	}
	,
	TestID -> "explicit option present in both, superset -> subset"
];
Test[
	DelegateOptions["opt1" -> "opt1ValueExplicit", f, g]
	,
	{
		"opt1" -> "opt1ValueExplicit",
		"opt2" -> "opt2Valuef"
	}
	,
	TestID -> "explicit option present in both, subset -> superset"
];
Test[
	DelegateOptions["opt1" -> "opt1ValueExplicit", f, h]
	,
	{
		"opt1" -> "opt1ValueExplicit"
	}
	,
	TestID -> "explicit option present in both, between intersecting"
];

EndTestSection[]


(* ::Subsection:: *)
(*explicit option present in "from" only*)


BeginTestSection["explicit option present in \"from\" only"]

Test[
	DelegateOptions["opt3" -> "opt3ValueExplicit", g, f]
	,
	{
		"opt1" -> "opt1Valueg",
		"opt2" -> "opt2Valueg"
	}
	,
	TestID -> "explicit option present in \"from\" only, superset -> subset"
];
Test[
	DelegateOptions["opt2" -> "opt2ValueExplicit", f, h]
	,
	{
		"opt1" -> "opt1Valuef"
	}
	,
	TestID -> "explicit option present in \"from\" only, between intersecting"
];

EndTestSection[]


(* ::Subsection:: *)
(*explicit option present in "to" only*)


BeginTestSection["explicit option present in \"to\" only"]

Test[
	DelegateOptions["opt3" -> "opt3ValueExplicit", f, g]
	,
	{
		"opt3" -> "opt3ValueExplicit",
		"opt1" -> "opt1Valuef",
		"opt2" -> "opt2Valuef"
	}
	,
	TestID -> "explicit option present in \"to\" only, subset -> superset"
];
Test[
	DelegateOptions["opt4" -> "opt4ValueExplicit", f, h]
	,
	{
		"opt4" -> "opt4ValueExplicit",
		"opt1" -> "opt1Valuef"
	}
	,
	TestID -> "explicit option present in \"to\" only, between intersecting"
];

EndTestSection[]


(* ::Subsection:: *)
(*explicit options complicated sequence*)


BeginTestSection["explicit options complicated sequence"]

Test[
	DelegateOptions[
		"opt1" -> "opt1ValueExplicit",
		{"opt2" :> "opt2ValueExplicit", "opt3" -> "opt3ValueExplicit"},
		g, f
	]
	,
	{
		"opt1" -> "opt1ValueExplicit",
		"opt2" :> "opt2ValueExplicit"
	}
	,
	TestID -> "explicit options complicated sequence, superset -> subset"
];
Test[
	DelegateOptions[
		"opt1" -> "opt1ValueExplicit",
		{"opt2" :> "opt2ValueExplicit", "opt3" -> "opt3ValueExplicit"},
		f, g
	]
	,
	{
		"opt1" -> "opt1ValueExplicit",
		"opt2" :> "opt2ValueExplicit",
		"opt3" -> "opt3ValueExplicit"
	}
	,
	TestID -> "explicit options complicated sequence, subset -> superset"
];
Test[
	DelegateOptions[
		"opt1" -> "opt1ValueExplicit",
		{"opt2" :> "opt2ValueExplicit", "opt4" -> "opt4ValueExplicit"},
		f, h
	]
	,
	{
		"opt1" -> "opt1ValueExplicit",
		"opt4" -> "opt4ValueExplicit"
	}
	,
	TestID -> "explicit options complicated sequence, between intersecting"
];

EndTestSection[]


(* ::Section:: *)
(*TearDown*)


(* Remove all symbols defined in current context. *)
Unprotect["`*"];
Quiet[Remove["`*"], {Remove::rmnsm}];


End[];
