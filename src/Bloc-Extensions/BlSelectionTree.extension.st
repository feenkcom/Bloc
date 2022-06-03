Extension { #name : #BlSelectionTree }

{ #category : #'*Bloc-Extensions' }
BlSelectionTree >> gtTreeFor: aView [
	<gtView>
	
	self hasRoot
		ifFalse: [ ^ aView empty ].
	
	^ self root gtTreeFor: aView
]
