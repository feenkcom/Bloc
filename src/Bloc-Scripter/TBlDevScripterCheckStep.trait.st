"
I define common check steps.

My users must also use {{gtClass:TBlDevScripterCheckStepCreation}}

"
Trait {
	#name : #TBlDevScripterCheckStep,
	#category : #'Bloc-Scripter-Scripter'
}

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> allSatisfy: anOneArgBlock [

	^ self addStep: (BlDevScripterCheckElementStep new block: [ :aCollection | 
			aCollection allSatisfy: [ :eachItem | anOneArgBlock cull: eachItem ] ]; referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> anySatisfy: anOneArgBlock [
	^ self addStep: (BlDevScripterCheckElementStep new block: [ :aCollection | 
			aCollection anySatisfy: [ :eachItem | anOneArgBlock cull: eachItem ] ]; referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> childrenCount: aNumber [
	^ self addStep: (BlDevScripterCheckChildrenCountStep new 
		childrenCount: aNumber;
		referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> click [
	^ self eventFired: BlClickEvent
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> do: anOneArgBlock [
	^ self addStep: (BlDevScripterCheckDoStep new block: anOneArgBlock; referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> elementIsOfClass: aClass [
	^ self addStep: (BlDevScripterCheckElementClassStep new 
		elementClass: aClass;
		referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> elementSatisfies: anOneArgBlock [
	^ (self satisfies: anOneArgBlock) referenceSender
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> equals: anEqualsBlock [
	^ self addStep: (BlDevScripterCheckElementEqualsStep new
		equalsBlock: anEqualsBlock;
		referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> eventFired: anEventClass [
	"An event of the given type was fired at least once."
	<scripterAssert>
	
	^ self addStep: (BlDevScripterCheckFiredEventsStep new 
		event: anEventClass;
		referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> eventFired: anEventClass times: anAmountOfTimes [
	"An event of the given type was fired an exact amount of times."
	<scripterAssert>
	
	^ self addStep: (BlDevScripterCheckFiredEventsStep new 
		event: anEventClass;
		amountOfTimes: anAmountOfTimes;
		referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> eventNotFired: anEventClass [
	"An event of the given type wasn't fired even once."
	<scripterAssert>

	^ self addStep: (BlDevScripterCheckNotFiredEventsStep new 
		event: anEventClass;
		referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> exists [
	"Target element (or other specified object) exists."
	<scripterAssert>

	^ self addStep: (BlDevScripterCheckElementExistsStep new referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> nonSatisfies: anOneArgBlock [
	^ self addStep: (BlDevScripterCheckElementStep new block: [ :aCollection | 
			aCollection allSatisfy: [ :eachItem | (anOneArgBlock cull: eachItem) not ] ]; referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> notExists [
	"Target element (or other specified object) doesn't exist."
	<scripterAssert>

	^ self addStep: (BlDevScripterCheckElementNotExistsStep new referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> satisfies: anOneArgBlock [
	"Given block evaluated with the current target returns true."
	<scripterAssert>

	^ self addStep: (BlDevScripterCheckElementStep new block: anOneArgBlock; referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> satisfies: anOneArgBlock description: aDescriptionOneArgBlock [
	^ self addStep: (BlDevScripterCheckElementStep new 
		block: anOneArgBlock; 
		description: aDescriptionOneArgBlock;
		referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> totalChildrenCount: aNumber [
	^ self addStep: (BlDevScripterCheckTotalChildrenCountStep new 
		totalChildrenCount: aNumber;
		referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> value: anOneArgBlock equals: anEqualsBlock [
	"Computed value equals to the provided one."
	<scripterAssert>

	^ self addStep: (BlDevScripterCheckElementValueStep new
		valueBlock: anOneArgBlock;
		equalsBlock: anEqualsBlock;
		referenceSender)
]
