Class {
	#name : #SmallMince,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'executableCode',
		'classesToObserve',
		'slicingCriteria',
		'minimize',
		'toMock'
	],
	#category : #'SmallMince-Core-0.Core'
}

{ #category : #examples }
SmallMince class >> exampleMario [

	SmallMince new
		classesToObserve: 'SmallMince-ToyExample' asPackage classes;
		slicingCriteria: [ :traces | 
			(traces associationsSelect: [ :kvp | kvp key theClass = SMEXQBlock ])
				collect: [ :history | history last ] ];
		executableCode: [ (SMEXMarioGameTest selector: #testRuns) run ];
		run
]

{ #category : #examples }
SmallMince class >> exampleSCAMPaper [

	SmallMince new
		classesToObserve: { 
				SMDriver.
				SMClassA.
				SMClassO.
				SMClassX.
				SMClassY.
				SMClassZ.
				SMClassR };
		slicingCriteria: [ :traces | 
			(traces associationsSelect: [ :kvp | kvp key theClass = SMClassO ]) 
				collect: [ :history | history third ] ];
		executableCode: [ SMDriverTest run: #test1 ];
		run
]

{ #category : #examples }
SmallMince class >> exampleSCAMPaper2 [

	SmallMince new
		classesToObserve: { 
				SMDriver.
				SMClassA.
				SMClassO.
				SMClassX.
				SMClassY.
				SMClassZ.
				SMClassR };
		slicingCriteria: [ :traces | 
			(traces associationsSelect: [ :kvp | kvp key theClass = SMClassO ]) 
				collect: [ :history | history at: (history detect: [ :h | h selector = #mo3 ]) receiver version ] ];
		executableCode: [ SMDriverTest run: #test2 ];
		run
]

{ #category : #examples }
SmallMince class >> exampleSCAMPaper3 [

	SmallMince new
		classesToObserve: { 
				SMDriver.
				SMClassA.
				SMClassO.
				SMClassX.
				SMClassY.
				SMClassZ.
				SMClassR };
		slicingCriteria: [ :traces | 
			(traces associationsSelect: [ :kvp | kvp key theClass = SMClassO ]) 
				collect: [ :history | 
					history at:
							(history detect: [ :h | h selector = #mo3 ]) receiver version ] ];
		minimize: true;
		executableCode: [ SMDriverTest run: #test2 ];
		run
]

{ #category : #examples }
SmallMince class >> exampleSCAMPaper4 [

	SmallMince new
		classesToObserve: { 
				SMDriver.
				SMClassA.
				SMClassO.
				SMClassX.
				SMClassY.
				SMClassZ.
				SMClassR };
		slicingCriteria: [ :traces | 
			(traces associationsSelect: [ :kvp | kvp key theClass = SMClassO ]) 
				collect: [ :history | 
					history at:
							(history detect: [ :h | h selector = #mo3 ]) receiver version ] ];
		minimize: true;
		toMock: {SMClassX};
		executableCode: [ SMDriverTest run: #test2 ];
		run
]

{ #category : #accessing }
SmallMince >> classesToObserve [
	^ classesToObserve
]

{ #category : #accessing }
SmallMince >> classesToObserve: anObject [
	classesToObserve := anObject
]

{ #category : #accessing }
SmallMince >> executableCode [
	^ executableCode
]

{ #category : #accessing }
SmallMince >> executableCode: anObject [
	executableCode := anObject
]

{ #category : #initialization }
SmallMince >> initialize [ 
	minimize := false
]

{ #category : #initialization }
SmallMince >> minimize: val [

	minimize := val
]

{ #category : #running }
SmallMince >> run [

	| tracer testMethodModels generatedTests |
	tracer := SMTracer new
		          captureTargets: self classesToObserve;
		          executableCode: self executableCode;
		          run.
	testMethodModels := SMDependencyBasedTestTransplantation new
		                    traces: tracer records;
		                    links: tracer links;
		                    slicingCriteria: self slicingCriteria;
		                    setMinimize: minimize;
		toMock: toMock;                    
		run.
	generatedTests := Dictionary new.
	testMethodModels keysAndValuesDo: [ :className :arrayOfMethods | 
		generatedTests
			at: className
			put: (arrayOfMethods collect: [ :methodModel | 
					 methodModel synthesisBy: SMDefaultSynthesizer new ]) ].
	generatedTests keysAndValuesDo: [ :key :value | 
		SMTestClassBuilder new buildFor: key theClass name methods: value ]
]

{ #category : #accessing }
SmallMince >> slicingCriteria [

	^ slicingCriteria
]

{ #category : #accessing }
SmallMince >> slicingCriteria: anObject [

	slicingCriteria := anObject
]

{ #category : #accessing }
SmallMince >> toMock [

	^ toMock
]

{ #category : #accessing }
SmallMince >> toMock: anObject [

	toMock := anObject
]
