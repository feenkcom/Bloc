Trait {
	#name : #TBlTextIteratorExamples,
	#category : #'Bloc-Text-Examples-Model'
}

{ #category : #'instance creation' }
TBlTextIteratorExamples >> attributed_end [
	<gtExample>
	| aText anIterator |

	aText := (self textForString: 'EarthHelloWorld').
	(aText from: 11 to: 15) appendingAdornment: [ BlElement new size: 10@10; background: Color lightGray ].
	
	anIterator := aText iterator.
	self assert: anIterator position equals: 0.
	
	^ anIterator
]

{ #category : #'examples - attributed end' }
TBlTextIteratorExamples >> attributed_end_next_attributed_end_at_1 [
	<gtExample>
	| anIterator aStart anEnd theAdornmentAttributes|

	anIterator := self attributed_end.

	anIterator
		nextAttributedEnd: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :theAttributes |
			aStart := indexStart.
			anEnd := indexEnd.
			theAdornmentAttributes := theAttributes ].

	self assert: aStart equals: 1.
	self assert: anEnd equals: 15.
	self assert: theAdornmentAttributes size equals: 1.
	self assert: anIterator position equals: 15.

	^ anIterator
]

{ #category : #'examples - span any' }
TBlTextIteratorExamples >> attributed_end_next_span_any_at_1 [
	<gtExample>
	| anIterator aStart anEnd hasAnyAttribute |

	anIterator := self attributed_end.

	anIterator
		nextSpanAny: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].
		
	self assert: aStart equals: 1.
	self assert: anEnd equals: 10.
	self assert: hasAnyAttribute not.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #'examples - span any' }
TBlTextIteratorExamples >> attributed_end_next_span_any_at_10 [
	<gtExample>
	| anIterator aStart anEnd hasAnyAttribute |

	anIterator := self attributed_end_next_span_any_at_1.

	anIterator
		nextSpanAny: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].
		
	self assert: aStart equals: 11.
	self assert: anEnd equals: 15.
	self assert: hasAnyAttribute.
	self assert: anIterator position equals: 15.

	^ anIterator
]

{ #category : #'instance creation' }
TBlTextIteratorExamples >> attributed_middle [
	<gtExample>
	| aText anIterator |

	aText := (self textForString: 'EarthHelloWorld').
	(aText from: 6 to: 10) appendingAdornment: [ BlElement new size: 10@10; background: Color lightGray ].
	
	anIterator := aText iterator.
	self assert: anIterator position equals: 0.
	
	^ anIterator
]

{ #category : #'examples - attributed end' }
TBlTextIteratorExamples >> attributed_middle_next_attributed_end_at_1 [
	<gtExample>
	| anIterator aStart anEnd theAdornmentAttributes|

	anIterator := self attributed_middle.

	anIterator
		nextAttributedEnd: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :theAttributes |
			aStart := indexStart.
			anEnd := indexEnd.
			theAdornmentAttributes := theAttributes ].
		
	self assert: aStart equals: 1.
	self assert: anEnd equals: 10.
	self assert: theAdornmentAttributes size equals: 1.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #'examples - attributed end' }
TBlTextIteratorExamples >> attributed_middle_next_attributed_end_at_10 [
	<gtExample>
	| anIterator aStart anEnd theAdornmentAttributes|

	anIterator := self attributed_middle_next_attributed_end_at_1.

	anIterator
		nextAttributedEnd: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :theAttributes |
			aStart := indexStart.
			anEnd := indexEnd.
			theAdornmentAttributes := theAttributes ].
		
	self assert: aStart equals: 11.
	self assert: anEnd equals: 15.
	self assert: theAdornmentAttributes isEmpty.
	self assert: anIterator position equals: 15.

	^ anIterator
]

{ #category : #'examples - span any' }
TBlTextIteratorExamples >> attributed_middle_next_span_any_at_1 [
	<gtExample>
	| anIterator aStart anEnd hasAnyAttribute |

	anIterator := self attributed_middle.

	anIterator
		nextSpanAny: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].
		
	self assert: aStart equals: 1.
	self assert: anEnd equals: 5.
	self assert: hasAnyAttribute not.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - span any' }
TBlTextIteratorExamples >> attributed_middle_next_span_any_at_10 [
	<gtExample>
	| anIterator aStart anEnd hasAnyAttribute |

	anIterator := self attributed_middle_next_span_any_at_5.

	anIterator
		nextSpanAny: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].
		
	self assert: aStart equals: 11.
	self assert: anEnd equals: 15.
	self assert: hasAnyAttribute not.
	self assert: anIterator position equals: 15.

	^ anIterator
]

{ #category : #'examples - span any' }
TBlTextIteratorExamples >> attributed_middle_next_span_any_at_5 [
	<gtExample>
	| anIterator aStart anEnd hasAnyAttribute |

	anIterator := self attributed_middle_next_span_any_at_1.

	anIterator
		nextSpanAny: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].
		
	self assert: aStart equals: 6.
	self assert: anEnd equals: 10.
	self assert: hasAnyAttribute.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #'instance creation' }
TBlTextIteratorExamples >> attributed_start [
	<gtExample>
	| aText anIterator |

	aText := (self textForString: 'EarthHelloWorld').
	(aText from: 1 to: 5) appendingAdornment: [ BlElement new size: 10@10; background: Color lightGray ].
	
	anIterator := aText iterator.
	self assert: anIterator position equals: 0.
	
	^ anIterator
]

{ #category : #'examples - attributed end' }
TBlTextIteratorExamples >> attributed_start_next_attributed_end_at_1 [
	<gtExample>
	| anIterator aStart anEnd theAdornmentAttributes|

	anIterator := self attributed_start.

	anIterator
		nextAttributedEnd: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :theAttributes |
			aStart := indexStart.
			anEnd := indexEnd.
			theAdornmentAttributes := theAttributes ].
		
	self assert: aStart equals: 1.
	self assert: anEnd equals: 5.
	self assert: theAdornmentAttributes size equals: 1.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - attributed end' }
TBlTextIteratorExamples >> attributed_start_next_attributed_end_at_5 [
	<gtExample>
	| anIterator aStart anEnd theAdornmentAttributes|

	anIterator := self attributed_start_next_attributed_end_at_1.

	anIterator
		nextAttributedEnd: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :theAttributes |
			aStart := indexStart.
			anEnd := indexEnd.
			theAdornmentAttributes := theAttributes ].

	self assert: aStart equals: 6.
	self assert: anEnd equals: 15.
	self assert: theAdornmentAttributes isEmpty.
	self assert: anIterator position equals: 15.

	^ anIterator
]

{ #category : #'examples - span any' }
TBlTextIteratorExamples >> attributed_start_next_span_any_at_1 [
	<gtExample>
	| anIterator aStart anEnd hasAnyAttribute |

	anIterator := self attributed_start.

	anIterator
		nextSpanAny: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].
		
	self assert: aStart equals: 1.
	self assert: anEnd equals: 5.
	self assert: hasAnyAttribute.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - span any' }
TBlTextIteratorExamples >> attributed_start_next_span_any_at_5 [
	<gtExample>
	| anIterator aStart anEnd hasAnyAttribute |

	anIterator := self attributed_start_next_span_any_at_1.

	anIterator
		nextSpanAny: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].
		
	self assert: aStart equals: 6.
	self assert: anEnd equals: 15.
	self assert: hasAnyAttribute not.
	self assert: anIterator position equals: 15.

	^ anIterator
]

{ #category : #'examples - attribute indices' }
TBlTextIteratorExamples >> findAttribute_beginning [
	<gtExample>
	| attribute text interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := (self textForString: 'HelloWorld')
		attributes: { attribute }
		from: 1 to: 5.

	text
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval equals: (1 to: 5).
	
	^ text
]

{ #category : #'examples - attribute indices' }
TBlTextIteratorExamples >> findAttribute_beginning_subtext_equal [
	<gtExample>
	| attribute text subText interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := (self textForString: 'HelloWorld')
		attributes: { attribute }
		from: 1 to: 5.
		
	subText := text from: 1 to: 5.

	subText
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval equals: (1 to: 5).
	
	^ subText
]

{ #category : #'examples - attribute indices' }
TBlTextIteratorExamples >> findAttribute_beginning_subtext_larger [
	<gtExample>
	| attribute text subText interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := (self textForString: 'HelloWorld')
		attributes: { attribute }
		from: 1 to: 5.

	subText := text from: 1 to: 7.

	subText
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval equals: (1 to: 5).
	
	^ subText
]

{ #category : #'examples - attribute indices' }
TBlTextIteratorExamples >> findAttribute_beginning_subtext_shifted [
	<gtExample>
	| attribute text subText interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := (self textForString: 'HelloWorld')
		attributes: { attribute }
		from: 1 to: 5.

	subText := text from: 3 to: 7.

	subText
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval equals: (1 to: 3).
	
	^ subText
]

{ #category : #'examples - attribute indices' }
TBlTextIteratorExamples >> findAttribute_beginning_subtext_smaller [
	<gtExample>
	| attribute text subText interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := (self textForString: 'HelloWorld')
		attributes: { attribute }
		from: 1 to: 5.
		
	subText := text from: 1 to: 2.

	subText
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval equals: (1 to: 2).
	
	^ subText
]

{ #category : #'examples - attribute indices' }
TBlTextIteratorExamples >> findAttribute_end [
	<gtExample>
	| attribute text interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := (self textForString: 'HelloWorld')
		attributes: { attribute }
		from: 6 to: 10.

	text
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval equals: (6 to: 10).
	
	^ text
]

{ #category : #'examples - attribute indices' }
TBlTextIteratorExamples >> findAttribute_middle [
	<gtExample>
	| attribute text interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := (self textForString: 'HelloWorld')
		attributes: { attribute }
		from: 3 to: 7.

	text
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval equals: (3 to: 7).
	
	^ text
]

{ #category : #'examples - attribute indices' }
TBlTextIteratorExamples >> findAttribute_none [
	<gtExample>
	| attribute text interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := (self textForString: 'HelloWorld').

	text
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval isNil.
	
	^ text
]

{ #category : #'instance creation' }
TBlTextIteratorExamples >> simple [
	<gtExample>
	| anIterator |

	anIterator := (self textForString: 'HelloWorld') iterator.
	self assert: anIterator position equals: 0.
	
	^ anIterator
]

{ #category : #'examples - attributed end' }
TBlTextIteratorExamples >> simple_next_attributed_end_at_0 [
	<gtExample>
	| anIterator aStart anEnd theAdornmentAttributes|

	anIterator := self simple.
	
	anIterator
		nextAttributedEnd: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :theAttributes |
			aStart := indexStart.
			anEnd := indexEnd.
			theAdornmentAttributes := theAttributes ].
		
	self assert: aStart equals: 1.
	self assert: anEnd equals: 10.
	self assert: theAdornmentAttributes isEmpty.
	self assert: anIterator position equals: 10.
	
	^ anIterator
]

{ #category : #'examples - span any' }
TBlTextIteratorExamples >> simple_next_span_any_at_0 [
	<gtExample>
	| anIterator aStart anEnd hasAnyAttribute |

	anIterator := self simple.
	
	anIterator
		nextSpanAny: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].
		
	self assert: aStart equals: 1.
	self assert: anEnd equals: 10.
	self assert: hasAnyAttribute not.
	self assert: anIterator position equals: 10.
	
	^ anIterator
]

{ #category : #'instance creation' }
TBlTextIteratorExamples >> textForString: aString [
	^ self explicitRequirement
]
