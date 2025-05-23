Class {
	#name : #BlRopeableCollectionFileExamples,
	#superclass : #Object,
	#instVars : [
		'largeFile'
	],
	#category : #'Bloc-Examples-Rope'
}

{ #category : #examples }
BlRopeableCollectionFileExamples >> at [
	<gtExample>
	<after: #deleteLargeFile>
	<return: #BlRopeableCollectionFileExamples>
	self assert: (self ropeableCollection at: 1) equals: $0.
	self assert: (self ropeableCollection at: 20) equals: $1.
	self assert: (self ropeableCollection at: 321456) equals: $3.
	self assert: (self ropeableCollection at: 654400) equals: Character lf
]

{ #category : #examples }
BlRopeableCollectionFileExamples >> copyFromTo [
	<gtExample>
	<after: #deleteLargeFile>
	<return: #BlRopeableCollectionFileExamples>
	| expected |
	self assert: (self ropeableCollection copyFrom: 1 to: 10) equals: '0000000000'.

	expected := 'efghi' , String lf , '00000'.
	self
		assert: (self ropeableCollection copyFrom: 199995 to: 200005)
		equals: expected
]

{ #category : #private }
BlRopeableCollectionFileExamples >> deleteLargeFile [

	largeFile ifNotNil: 
		[ largeFile ensureDelete.
		largeFile := nil ].
]

{ #category : #examples }
BlRopeableCollectionFileExamples >> emptyFile [
	<gtExample>
	<return: #FileReference>
	^ (FileSystem memory root / 'empty.file') ensureCreateFile
]

{ #category : #examples }
BlRopeableCollectionFileExamples >> emptyFileSize [
	<gtExample>
	<return: #BlRopeableCollectionFileExamples>
	| ropeSize |
	ropeSize := (BlRunRopedText file: self emptyFile) size.
	self assert: ropeSize equals: 0
]

{ #category : #examples }
BlRopeableCollectionFileExamples >> largeFile [
	<gtExample>
	<return: #FileReference>
	^ largeFile
		ifNil: [ largeFile := FileSystem memory / 'test.txt'.
			largeFile
				writeStreamDo: [ :stream | 
					1
						to: 10000
						do: [ :l | 
							1 to: 9 do: [ :i | stream << ((l - 1) * 10 + i - 1 printPaddedWith: $0 to: 10) ].
							stream
								<< 'abcdefghi';
								lf ] ].
			largeFile ]
]

{ #category : #examples }
BlRopeableCollectionFileExamples >> mapEntryForLarge [
	<gtExample>
	<return: #BlRopeableCollectionFileExamples>
	| collection |
	collection := BlRopeableCollectionFile new.
	10
		to: 1000
		by: 10
		do: [ :i | collection map add: i -> (i - 1) ].

	self assert: (collection mapEntryFor: 5) equals: 1 -> 0.

	15
		to: 1005
		by: 10
		do: [ :i | self assert: (collection mapEntryFor: i) equals: i - 5 -> (i - 6) ].

	10
		to: 1000
		by: 10
		do: [ :i | self assert: (collection mapEntryFor: i) equals: i -> (i - 1) ].

	self assert: (collection mapEntryFor: 1010) equals: 1000 -> 999
]

{ #category : #examples }
BlRopeableCollectionFileExamples >> mapEntryForSmall [
	<gtExample>
	<return: #BlRopeableCollectionFileExamples>
	| collection |
	collection := BlRopeableCollectionFile new.
	collection map add: 10 -> 9.

	self assert: (collection mapEntryFor: 1) equals: 1 -> 0.
	self assert: (collection mapEntryFor: 5) equals: 1 -> 0.
	self assert: (collection mapEntryFor: 10) equals: 10 -> 9.
	self assert: (collection mapEntryFor: 12) equals: 10 -> 9
]

{ #category : #examples }
BlRopeableCollectionFileExamples >> rope [
	<gtExample>
	<return: #BlRunRopedText>
	^ BlRunRopedText rope: (BlCollectionRope collection: self ropeableCollection)
]

{ #category : #examples }
BlRopeableCollectionFileExamples >> ropeableCollection [
	<gtExample>
	<return: #BlRopeableCollectionFile>
	^ BlRopeableCollectionFile new fileReference: self largeFile
]
