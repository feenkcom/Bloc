"
I make sure that a host space is valid and re-create it if needed

"
Class {
	#name : #BlSpaceFrameHostValidationPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Bloc-Space - Frame'
}

{ #category : #accessing }
BlSpaceFrameHostValidationPhase >> name [
	<return: #String>
	
	^ 'Host validation'
]

{ #category : #actions }
BlSpaceFrameHostValidationPhase >> reopenSpace: aSpace [
	aSpace host: BlHost pickHost
]

{ #category : #actions }
BlSpaceFrameHostValidationPhase >> runOn: aSpace [
	| isStillAvailable |
	
	aSpace hasHostSpace
		ifFalse: [ ^ self ].
		
	
	isStillAvailable := aSpace host isStillAvailable.
	
	aSpace host isStillAvailable
		ifTrue: [ self validateHostSpace: aSpace ]
		ifFalse: [ self reopenSpace: aSpace ]
]

{ #category : #actions }
BlSpaceFrameHostValidationPhase >> validateHostSpace: aSpace [
	aSpace hostSpace needsRebuild
		ifFalse: [ ^ self ].
		
	aSpace beDirtyArea.

	aSpace host destroyHostSpaceFor: aSpace.
	aSpace host createHostSpaceFor: aSpace.
	aSpace hostSpace show
]
