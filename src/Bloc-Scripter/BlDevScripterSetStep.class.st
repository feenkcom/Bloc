"
I store values into the scripter's state during step execution.

I support three storage modes:
- {{gtMethod:BlDevScripterSetStep>>#model:}} — stores a model object accessible later via {{gtMethod:TBlDevScripterTarget>>#onModel|label=#selector}} targeting
- {{gtMethod:BlDevScripterSetStep>>#element:}} — sets the scripter's root element, optionally built from the model
- {{gtMethod:BlDevScripterSetStep>>#key:value:}} — stores arbitrary key-value pairs in scripter user data

Access me via {{gtMethod:TBlDevScripterActionStep>>#set|label=#selector}} on the scripter or any composite step.

## Usage Examples

- {{gtClass:BlScripterSetStepUsageExamples}} — canonical usage patterns

## Example

{{gtExample:BlScripterSetStepUsageExamples>>#setModelAndAssert|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #BlDevScripterSetStep,
	#superclass : #BlDevScripterTargetedStep,
	#instVars : [
		'storage'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterSetStep >> defaultLabel [
	^ self storage 
		ifNil: [ 'Set' ]
		ifNotNil: [ :aStorage | aStorage printString ]
]

{ #category : #initialization }
BlDevScripterSetStep >> defaultTarget [
	^ BlDevScripterAsTarget new
]

{ #category : #accessing }
BlDevScripterSetStep >> element: anOneArgBlock [
	self storage: (BlDevScripterElementStorage new block: anOneArgBlock)
]

{ #category : #accessing }
BlDevScripterSetStep >> key: aKeyBlock value: aValueBlock [
	self storage: (BlDevScripterUserDataStorage new key: aKeyBlock; value: aValueBlock)
]

{ #category : #accessing }
BlDevScripterSetStep >> model: anOneArgBlock [
	self storage: (BlDevScripterModelStorage new block: anOneArgBlock)
]

{ #category : #actions }
BlDevScripterSetStep >> playOn: aScripter [
	"Where do we get an information"
	| aTarget |
	aTarget := self target findTargetStartingInScripter: aScripter.
	self storage storeFrom: aTarget scripter: aScripter.
]

{ #category : #accessing }
BlDevScripterSetStep >> storage [
	^ storage
]

{ #category : #accessing }
BlDevScripterSetStep >> storage: anObject [
	storage := anObject
]
