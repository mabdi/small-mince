Extension { #name : #BlockClosure }

{ #category : #'*TestGrinder' }
BlockClosure >> tg_valueReference [
	^ TGBlockValue  with: self
]
