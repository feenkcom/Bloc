Class {
	#name : #BlDevScripterSecondaryClickStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'localPosition'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterSecondaryClickStep >> defaultLabel [
	^ 'Secondary Click'
]

{ #category : #accessing }
BlDevScripterSecondaryClickStep >> localPosition [
	^ localPosition
]

{ #category : #accessing }
BlDevScripterSecondaryClickStep >> localPosition: aPoint [
	localPosition := aPoint
]

{ #category : #actions }
BlDevScripterSecondaryClickStep >> playOn: aScripter [
	self localPosition
		ifNil: [ self
				setMousePosition: (BlSpace
						simulateSecondaryClickOn: (self target findTargetStartingInScripter: aScripter))
				in: aScripter ]
		ifNotNil: [ :aPosition | 
			self
				setMousePosition: (BlSpace
						simulateSecondaryClickOn: (self target findTargetStartingInScripter: aScripter)
						atLocalPosition: aPosition)
				in: aScripter ].

	aScripter pulse
]
