Class {
	#name : #BlDevScripterStepProperties,
	#superclass : #Object,
	#instVars : [
		'properties'
	],
	#category : #'Bloc-Scripter-Scripter-Properties'
}

{ #category : #adding }
BlDevScripterStepProperties >> add: aProperty [
	properties add: aProperty
]

{ #category : #adding }
BlDevScripterStepProperties >> addScreenshotForm: aForm [
	self add: (BlDevScripterStepScreenshot new form: aForm)
]

{ #category : #accessing }
BlDevScripterStepProperties >> gtScreenshotFor: aView [
	<gtView>
	self properties ifNil: [ ^ aView empty ].
	^ self properties 
		detect: [ :eachProperty | eachProperty isScreenshot ]
		ifFound: [ :aScreenshot | aScreenshot gtScreenshotFor: aView ]
		ifNone: [ aView empty ]
]

{ #category : #initialization }
BlDevScripterStepProperties >> initialize [
	super initialize.
	properties := OrderedCollection new: 2.
]

{ #category : #accessing }
BlDevScripterStepProperties >> properties [
	^ properties
]

{ #category : #accessing }
BlDevScripterStepProperties >> reference [
	<return: #BlDevScripterReference>
	^ self properties 
		detect: [ :eachProperty | eachProperty isReference ]
		ifFound: [ :aReference | aReference ]
		ifNone: [ BlDevScripterReference null ]
]

{ #category : #accessing }
BlDevScripterStepProperties >> reference: aBlDevScripterReference [
	self properties removeAllSuchThat: #isReference.
	self add: aBlDevScripterReference
]

{ #category : #accessing }
BlDevScripterStepProperties >> stepExecution [
	<return: #BlDevScripterStepExecutionProperty>
	^ self properties 
		detect: [ :eachProperty | eachProperty isStepExecution ]
		ifFound: [ :aProperty | aProperty ]
		ifNone: [ | aProperty |
			self properties add: (aProperty := BlDevScripterStepExecutionProperty new).
			aProperty ]
]
