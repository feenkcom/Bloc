Class {
	#name : #BlDevScripterMouseUpStep,
	#superclass : #BlDevScripterMouseStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMouseUpStep >> defaultLabel [
	^ 'Mouse up'
]

{ #category : #actions }
BlDevScripterMouseUpStep >> playOn: aScripter [
	self modifiers
		ifNil: [ BlSpace simulateMouseUpOn: aScripter element at: (self getMousePositionIn: aScripter) ]
		ifNotNil: [ :aModifiers |
			 BlSpace simulateMouseUpOn: aScripter element modifiers: aModifiers at: (self getMousePositionIn: aScripter)  ].
	aScripter pulse
]
