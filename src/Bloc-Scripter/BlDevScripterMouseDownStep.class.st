Class {
	#name : #BlDevScripterMouseDownStep,
	#superclass : #BlDevScripterMouseStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMouseDownStep >> defaultLabel [
	^ 'Mouse down'
]

{ #category : #actions }
BlDevScripterMouseDownStep >> playOn: aScripter [
	self modifiers 
		ifNil: [ 
			BlSpace simulateMouseDownOn: aScripter element at: (self getMousePositionIn: aScripter) ]
		ifNotNil: [ :aModifiers | 
			BlSpace simulateMouseDownOn: aScripter element modifiers: aModifiers at: (self getMousePositionIn: aScripter) ].
	aScripter pulse
]
