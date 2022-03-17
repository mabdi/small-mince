Class {
	#name : #BaselineOfSmallMince,
	#superclass : #BaselineOf,
	#category : #BaselineOfSmallMince
}

{ #category : #baselines }
BaselineOfSmallMince >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec package: 'SmallMince-Core'.
			spec package: 'SmallMince-Tests'
			with: [ spec requires: #( 'SmallMince-Core' ) ].
			spec group: 'core' with: #('SmallMince-Core').
			spec group: 'tests' with: #('core' 'SmallMince-ToyExample' 'SmallMince-Tests').
			 ]
]
