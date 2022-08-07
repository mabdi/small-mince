Class {
	#name : #BaselineOfSmallMince,
	#superclass : #BaselineOf,
	#category : #BaselineOfSmallMince
}

{ #category : #baselines }
BaselineOfSmallMince >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Mocketry'
			with: [ 
			spec repository: 'github://dionisiydk/Mocketry:versionTagOrBranch' ].
		spec
			package: 'SmallMince-Core'
			with: [ spec requires: #( 'Mocketry' ) ].
		spec
			package: 'SmallMince-Tests'
			with: [ spec requires: #( 'SmallMince-Core' ) ].
		spec
			package: 'SmallMince-ToyExample'
			with: [ spec requires: #( 'SmallMince-Tests' ) ].
		spec group: 'core' with: #( 'SmallMince-Core' ).
		spec
			group: 'tests'
			with: #( 'core' 'SmallMince-ToyExample' 'SmallMince-Tests' ) ]
]
