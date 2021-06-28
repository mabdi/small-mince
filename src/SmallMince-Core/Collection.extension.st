Extension { #name : #Collection }

{ #category : #'*SmallMince-Core' }
Collection >> sm_valueReference [
	^ SMListValue with: self
]
