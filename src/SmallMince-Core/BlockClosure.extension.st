Extension { #name : #BlockClosure }

{ #category : #'*SmallMince-Core' }
BlockClosure >> sm_valueReference [
	^ SMBlockValue  with: self
]
