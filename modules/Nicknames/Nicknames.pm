

package Nicknames;
require Exporter;
use strict;

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
use vars qw(%rootnames %nicknames);

$VERSION= '0.01';
@ISA = qw(Exporter);
@EXPORT  = qw(nicknames rootname);
@EXPORT_OK = ();

%EXPORT_TAGS = (
	ALL => [@EXPORT, @EXPORT_OK]
);


# return list of nicknames for a name
sub nicknames {
	# initial cap
	my $rootname = ucfirst(lc(shift));
	return $rootnames{$rootname} if exists $rootnames{$rootname};
}

# return rootname for a nickname
sub rootname {
	my $nickname = ucfirst(lc(shift));
	return $nicknames{$nickname} if exists $nicknames{$nickname};
}

%rootnames = (
          'Zadock' => [
                        'Dick',
                        'Dock',
                        'Melchizedek',
                        'Zed'
                      ],
          'Christopher' => [
                             'Chris',
                             'Christian',
                             'Kester',
                             'Kit',
                             'Kris'
                           ],
          'Janet' => [
                       'Jan'
                     ],
          'Levone' => [
                        'Von'
                      ],
          'Eugenia' => [
                         'Euy',
                         'Geney',
                         'Genie',
                         'Geny'
                       ],
          'Stanley' => [
                         'Stan'
                       ],
          'Montesque' => [
                           'Monty'
                         ],
          'Teresa' => [
                        'Terrie',
                        'Terri',
                        'Terry',
                        'Tessie',
                        'Tess',
                        'Tyrza'
                      ],
          'Viola' => [
                       'Ola',
                       'Vi'
                     ],
          'Zachariah' => [
                           'Rye',
                           'Zacharey',
                           'Zacharias',
                           'Zacharie',
                           'Zachary',
                           'Zachey',
                           'Zachie',
                           'Zachy',
                           'Zach',
                           'Zeke'
                         ],
          'Desiree' => [
                         'Desey',
                         'Desie',
                         'Desirey',
                         'Desirie',
                         'Desiry',
                         'Desree',
                         'Desrey',
                         'Desrie',
                         'Desry',
                         'Desy'
                       ],
          'William' => [
                         'Bela',
                         'Biff',
                         'Billey',
                         'Billie',
                         'Bill',
                         'Billy',
                         'Bud',
                         'Wiley',
                         'Wilhelm',
                         'Wilie',
                         'Willie',
                         'Willis',
                         'Will',
                         'Willy',
                         'Wily'
                       ],
          'Eliza' => [
                       'Elizabeth'
                     ],
          'Warren' => [
                        'Rennie',
                        'Renny'
                      ],
          'Leanne' => [
                        'Annie',
                        'Lea'
                      ],
          'Ambrose' => [
                         'Brose'
                       ],
          'Merlin' => [
                        'Merle',
                        'Merlyn'
                      ],
          'Dell' => [
                      'Adela',
                      'Adelaide',
                      'Delilah'
                    ],
          'Josetta' => [
                         'Jettie'
                       ],
          'Linda' => [
                       'Lidia',
                       'Lindy',
                       'Linette',
                       'Lyddey',
                       'Lyddie',
                       'Lyddy',
                       'Lydey',
                       'Lydie',
                       'Lydy',
                       'Lynette'
                     ],
          'Octavia' => [
                         'Tave',
                         'Tavia'
                       ],
          'Sybill' => [
                        'Sibbie'
                      ],
          'Annette' => [
                         'Anna',
                         'Nan',
                         'Nettie'
                       ],
          'Althea' => [
                        'Thea'
                      ],
          'Matilda' => [
                         'Maddie',
                         'Maddi',
                         'Maddy',
                         'Mathilda',
                         'Mat',
                         'Matty',
                         'Maud',
                         'Tilda',
                         'Tillie',
                         'Tilly'
                       ],
          'Lincoln' => [
                         'Link'
                       ],
          'Albert' => [
                        'Al',
                        'Bert',
                        'Bird'
                      ],
          'Geoffrey' => [
                          'Geoff',
                          'Jeff',
                          'Jeffrey'
                        ],
          'Barbara' => [
                         'Bab',
                         'Babbey',
                         'Babbie',
                         'Babby',
                         'Babs',
                         'Barbarey',
                         'Barbarie',
                         'Barbary',
                         'Barb',
                         'Barberey',
                         'Barberie',
                         'Barbery',
                         'Barbey',
                         'Barbie',
                         'Barby',
                         'Bobbie',
                         'Bonnie'
                       ],
          'Olive' => [
                       'Ollie'
                     ],
          'Natalie' => [
                         'Nat',
                         'Nattie',
                         'Nettie',
                         'Talley',
                         'Tallie',
                         'Tally'
                       ],
          'Magdelina' => [
                           'Magdalen'
                         ],
          'Wilber' => [
                        'Wib',
                        'Wilbur'
                      ],
          'Maxwell' => [
                         'Max'
                       ],
          'Miranda' => [
                         'Mandy',
                         'Mari',
                         'Mira',
                         'Randy'
                       ],
          'Laodicia' => [
                          'Cenia',
                          'Dicy'
                        ],
          'Lousie' => [
                        'Eloise',
                        'Elouise',
                        'Lois',
                        'Louetta',
                        'Louisa'
                      ],
          'Deborah' => [
                         'Debbe',
                         'Debbey',
                         'Debbie',
                         'Debby',
                         'Deb',
                         'Debi',
                         'Debora',
                         'Debra'
                       ],
          'Bonita' => [
                        'Bonney',
                        'Bonnie',
                        'Bonny'
                      ],
          'Refina' => [
                        'Fina'
                      ],
          'Rufus' => [
                       'Ruffie'
                     ],
          'Jules' => [
                       'Julie'
                     ],
          'Democrates' => [
                            'Mock'
                          ],
          'Providence' => [
                            'Provy'
                          ],
          'Stanford' => [
                          'Stan'
                        ],
          'Theresa' => [
                         'Teresa',
                         'Terrie',
                         'Terri',
                         'Terry',
                         'Tessa',
                         'Tessey',
                         'Tessie',
                         'Tess',
                         'Tessy',
                         'Therese',
                         'Thirsa',
                         'Thriza',
                         'Thursa',
                         'Ticey',
                         'Ticie',
                         'Ticy',
                         'Tracey',
                         'Tracie',
                         'Tracy',
                         'Trissy'
                       ],
          'Azubah' => [
                        'Zubiah'
                      ],
          'Alverta' => [
                         'Vert',
                         'Virdie'
                       ],
          'Guilford' => [
                          'Gil',
                          'Gill'
                        ],
          'Carthaette' => [
                            'Etta',
                            'Etty'
                          ],
          'Lavinia' => [
                         'Ina',
                         'Lavina',
                         'Louvina',
                         'Louvinia',
                         'Vina',
                         'Viney',
                         'Vinie',
                         'Viny',
                         'Vonnie',
                         'Wyncha'
                       ],
          'Diana' => [
                       'Diane',
                       'Dicey',
                       'Di',
                       'Didi'
                     ],
          'Marguerite' => [
                            'Daisy'
                          ],
          'Nowell' => [
                        'Noel'
                      ],
          'Savannah' => [
                          'Anna',
                          'Annie',
                          'Anny',
                          'Vannie'
                        ],
          'Algernon' => [
                          'Algy'
                        ],
          'Kristel' => [
                         'Chris',
                         'Kris',
                         'Krissey',
                         'Krissie',
                         'Krissy'
                       ],
          'Aline' => [
                       'Adeline'
                     ],
          'Samson' => [
                        'Sam'
                      ],
          'Arizona' => [
                         'Ona',
                         'Onie'
                       ],
          'Walter' => [
                        'Wallie',
                        'Wally',
                        'Walt',
                        'Wat'
                      ],
          'Othello' => [
                         'Ote',
                         'Otis'
                       ],
          'King' => [
                      'Kingsley',
                      'Kingslie',
                      'Kingsly',
                      'Kingston'
                    ],
          'Sigfrid' => [
                         'Sid'
                       ],
          'Natasha' => [
                         'Nat',
                         'Tasha'
                       ],
          'Marcus' => [
                        'Marc',
                        'Mark'
                      ],
          'Nancy' => [
                       'Agnes',
                       'Ann',
                       'Nance',
                       'Nan',
                       'Nannie'
                     ],
          'Deirdre' => [
                         'Dede',
                         'Didi'
                       ],
          'Melvina' => [
                         'Vina'
                       ],
          'Enedina' => [
                         'Nina'
                       ],
          'Ernestine' => [
                           'Erna',
                           'Teeny',
                           'Tina'
                         ],
          'Brittany' => [
                          'Britt'
                        ],
          'Tamara' => [
                        'Tamarra',
                        'Tammey',
                        'Tammie',
                        'Tammi',
                        'Tammy',
                        'Temera'
                      ],
          'Miriam' => [
                        'Mary',
                        'Mickie',
                        'Micky',
                        'Mitzi'
                      ],
          'Cameron' => [
                         'Cam'
                       ],
          'Eloise' => [
                        'Heloise',
                        'Louise'
                      ],
          'Wesley' => [
                        'Wes'
                      ],
          'Aquilla' => [
                         'Acuilla',
                         'Quil',
                         'Quilla',
                         'Quilley',
                         'Quillie',
                         'Quilly'
                       ],
          'Mathilda' => [
                          'Maddie',
                          'Maddi',
                          'Maddy',
                          'Patty',
                          'Tillie',
                          'Tilly'
                        ],
          'Matthew' => [
                         'Matthias',
                         'Matt',
                         'Thias',
                         'Thys'
                       ],
          'Earnest' => [
                         'Ernest',
                         'Erney',
                         'Ernie',
                         'Erny'
                       ],
          'Eighta' => [
                        'Athy'
                      ],
          'Anderson' => [
                          'Ander',
                          'Andre'
                        ],
          'Lorenzo' => [
                         'Loren'
                       ],
          'Laurance' => [
                          'Larry',
                          'Laurie'
                        ],
          'Rhyna' => [
                       'Rhynie'
                     ],
          'Benedict' => [
                          'Bennett'
                        ],
          'Angela' => [
                        'Angel',
                        'Angelica',
                        'Angelina',
                        'Angeline',
                        'Angey',
                        'Angie',
                        'Angy',
                        'Jane'
                      ],
          'Pauline' => [
                         'Polly'
                       ],
          'Lillian' => [
                         'Lila',
                         'Liley',
                         'Lilie',
                         'Lillah',
                         'Lilley',
                         'Lillie',
                         'Lil',
                         'Lilly',
                         'Lily',
                         'Lolly',
                         'Odie'
                       ],
          'Asenath' => [
                         'Assene',
                         'Nathey',
                         'Sene'
                       ],
          'Hilary' => [
                        'Hillie',
                        'Hilly'
                      ],
          'Waldo' => [
                       'Oswald'
                     ],
          'Harris' => [
                        'Harry'
                      ],
          'Lucinda' => [
                         'Cindie',
                         'Cindi',
                         'Cindy',
                         'Lou',
                         'Lucie',
                         'Luci',
                         'Lucy'
                       ],
          'Simeon' => [
                        'Simon',
                        'Sim',
                        'Sion'
                      ],
          'Socrates' => [
                          'Crate'
                        ],
          'Sebastian' => [
                           'Sebby'
                         ],
          'Norman' => [
                        'Norm'
                      ],
          'Alison' => [
                        'Ali'
                      ],
          'Adrian' => [
                        'Rian'
                      ],
          'Isabelle' => [
                          'Bella',
                          'Belle',
                          'Cybilla',
                          'Elizabeth',
                          'Ib',
                          'Issy',
                          'Nib',
                          'Sabe',
                          'Sabra',
                          'Sibella',
                          'Tibbie'
                        ],
          'Drusilla' => [
                          'Silla'
                        ],
          'Danielle' => [
                          'Danelle',
                          'Daney',
                          'Dani',
                          'Danie',
                          'Danni',
                          'Dannie',
                          'Dany',
                          'Ellie',
                          'Etc.'
                        ],
          'Alexis' => [
                        'Lexi'
                      ],
          'Ivan' => [
                      'John'
                    ],
          'Cyrenius' => [
                          'Cene',
                          'Renius',
                          'Serene',
                          'Swene'
                        ],
          'Pharaba' => [
                         'Ferbey',
                         'Ferbie',
                         'Ferby',
                         'Pherbia',
                         'Pheriba'
                       ],
          'Aurelia' => [
                         'Aurilla',
                         'Ora',
                         'Ree',
                         'Rilly'
                       ],
          'Dickson' => [
                         'Dick'
                       ],
          'Sheila' => [
                        'Cecilia'
                      ],
          'Katherine' => [
                           'Cate',
                           'Catherine',
                           'Cathey',
                           'Cathie',
                           'Cathleen',
                           'Cathy',
                           'Cat',
                           'Katarina',
                           'Kate',
                           'Katey',
                           'Kathe',
                           'Katherina',
                           'Kathey',
                           'Kathie',
                           'Kathleen',
                           'Kathryn',
                           'Kathy',
                           'Katie',
                           'Kat',
                           'Katy',
                           'Kay',
                           'Kit',
                           'Kitsey',
                           'Kitsie',
                           'Kitsy',
                           'Kittey',
                           'Kittie',
                           'Kitty',
                           'Trina'
                         ],
          'Ophelia' => [
                         'Orphelia',
                         'Phelia'
                       ],
          'Gregor' => [
                        'Gregg',
                        'Greg'
                      ],
          'Elisabeth' => [
                           'Lisa'
                         ],
          'Ferdinand' => [
                           'Ferdey',
                           'Ferdie',
                           'Ferdy',
                           'Fred'
                         ],
          'Lorraine' => [
                          'Lorrie',
                          'Rana'
                        ],
          'Jean' => [
                      'Jennie',
                      'Joanna'
                    ],
          'Orilla' => [
                        'Ora',
                        'Ree',
                        'Rilly'
                      ],
          'Maxine' => [
                        'Max'
                      ],
          'Marjorie' => [
                          'Jerri',
                          'Jerry',
                          'Madge',
                          'Marge',
                          'Margie',
                          'Marg'
                        ],
          'Reuben' => [
                        'Rube',
                        'Rubey',
                        'Rubie',
                        'Ruby'
                      ],
          'Tamarra' => [
                         'Tammy'
                       ],
          'Katharine' => [
                           'Cate',
                           'Cathy',
                           'Cat',
                           'Kate',
                           'Kathy',
                           'Kay',
                           'Kit',
                           'Kittie',
                           'Kitty'
                         ],
          'Lafayette' => [
                           'Fate',
                           'Fayette',
                           'Laffey',
                           'Laffie',
                           'Laffy',
                           'Leffey',
                           'Leffie',
                           'Leffy',
                           'Left'
                         ],
          'Lester' => [
                        'Les'
                      ],
          'Emanuel' => [
                         'Immanuel',
                         'Manny',
                         'Manuel'
                       ],
          'Abel' => [
                      'Abe'
                    ],
          'Theodosia' => [
                           'Dosia',
                           'Theodora',
                           'Theo'
                         ],
          'Margaret' => [
                          'Daisey',
                          'Daisie',
                          'Daisy',
                          'Greta',
                          'Gretta',
                          'Madge',
                          'Maggie',
                          'Maggi',
                          'Maggy',
                          'Mags',
                          'Maisey',
                          'Maisie',
                          'Maisy',
                          'Margaretha',
                          'Margaretta',
                          'Marge',
                          'Margerey',
                          'Margerie',
                          'Margery',
                          'Margey',
                          'Margie',
                          'Margo',
                          'Margy',
                          'Marjorey',
                          'Marjorie',
                          'Marjory',
                          'Megan',
                          'Meg',
                          'Meta',
                          'Metta',
                          'Midge',
                          'Peggey',
                          'Peggie',
                          'Peggy',
                          'Peg'
                        ],
          'Hubert' => [
                        'Bert',
                        'Hub',
                        'Hugh',
                        'Hugo'
                      ],
          'Ursula' => [
                        'Sula',
                        'Sulie'
                      ],
          'Monteleon' => [
                           'Monte'
                         ],
          'Rudolph' => [
                         'Dolph',
                         'Rolf',
                         'Rollo',
                         'Rudi',
                         'Rudy'
                       ],
          'Parthenia' => [
                           'Parsuney',
                           'Parsunie',
                           'Parsuny',
                           'Pasooney',
                           'Pasoonie',
                           'Pasoony',
                           'Phenie',
                           'Teeny',
                           'Theney',
                           'Thenie',
                           'Theny'
                         ],
          'Frederik' => [
                          'Derick',
                          'Eric',
                          'Freddie',
                          'Freddy',
                          'Fred',
                          'Fredric',
                          'Frish',
                          'Fritz'
                        ],
          'Laurinda' => [
                          'Laura',
                          'Lorinda'
                        ],
          'Brian' => [
                       'Bryan',
                       'Bryant',
                       'Rian',
                       'Ryan'
                     ],
          'Elaine' => [
                        'Alaina',
                        'Elaina',
                        'Helen',
                        'Lainey',
                        'Lainie',
                        'Lainy'
                      ],
          'Winston' => [
                         'Win'
                       ],
          'Adeline' => [
                         'Linney'
                       ],
          'Campbell' => [
                          'Cam'
                        ],
          'Oliver' => [
                        'Ollie',
                        'Olly'
                      ],
          'Laura' => [
                       'Laurie',
                       'Lee'
                     ],
          'Reynold' => [
                         'Reginald'
                       ],
          'Chloe' => [
                       'Clo'
                     ],
          'Dominick' => [
                          'Dom'
                        ],
          'Abiel' => [
                       'Biel'
                     ],
          'Abijah' => [
                        'Ab',
                        'Abiah',
                        'Biah',
                        'Bige'
                      ],
          'Olivia' => [
                        'Livey',
                        'Livia',
                        'Livie',
                        'Livy',
                        'Nolley',
                        'Nollie',
                        'Nolly',
                        'Olive'
                      ],
          'Ernest' => [
                        'Ernie'
                      ],
          'Delilah' => [
                         'Della',
                         'Dell',
                         'Lila',
                         'Lil'
                       ],
          'Adela' => [
                       'Della'
                     ],
          'Loretta' => [
                         'Etta',
                         'Laura',
                         'Lorrie',
                         'Retta'
                       ],
          'Barbery' => [
                         'Barbara'
                       ],
          'Terrence' => [
                          'Terrie',
                          'Terri',
                          'Terry'
                        ],
          'Robert' => [
                        'Bobbie',
                        'Bobby',
                        'Bob',
                        'Dobbin',
                        'Dob',
                        'Hobkin',
                        'Hob',
                        'Robin',
                        'Rob',
                        'Rupert'
                      ],
          'Benton' => [
                        'Ben'
                      ],
          'Stephen' => [
                         'Steph',
                         'Step',
                         'Steven',
                         'Steve',
                         'Stevie',
                         'Stevy'
                       ],
          'Harry' => [
                       'Harold',
                       'Henry'
                     ],
          'Ebenezer' => [
                          'Eb',
                          'Eben'
                        ],
          'Duane' => [
                       'Dewayne',
                       'Dwane',
                       'Dwayne'
                     ],
          'Bennett' => [
                         'Ben'
                       ],
          'Nathaniel' => [
                           'Fannney',
                           'Fannnie',
                           'Fannny',
                           'Jonathan',
                           'Nate',
                           'Nathan',
                           'Nat',
                           'Natty',
                           'Tan',
                           'Than'
                         ],
          'Lemuel' => [
                        'Lem'
                      ],
          'Alfred' => [
                        'Al',
                        'Alf',
                        'Alfie',
                        'Alfreda',
                        'Fred',
                        'Freddie',
                        'Freddy'
                      ],
          'Patience' => [
                          'Pat',
                          'Patty'
                        ],
          'Hamilton' => [
                          'Ham',
                          'Hamp'
                        ],
          'Cynthia' => [
                         'Cindi',
                         'Cindie',
                         'Cindy',
                         'Cinthia',
                         'Lucinda',
                         'Sina'
                       ],
          'Alberta' => [
                         'Abertina',
                         'Albert',
                         'Albertine',
                         'Allie',
                         'Bert',
                         'Bertie'
                       ],
          'Nathanael' => [
                           'Nate',
                           'Nathan',
                           'Nat'
                         ],
          'Eleanor' => [
                         'Elaine',
                         'Elenora',
                         'Elinamifia',
                         'Ella',
                         'Ellen',
                         'Ellie',
                         'Elnora',
                         'Helen',
                         'Lanna',
                         'Leonora',
                         'Nell',
                         'Nellie',
                         'Nelly',
                         'Nora'
                       ],
          'Zachary' => [
                         'Zach'
                       ],
          'Josephine' => [
                           'Fina',
                           'Joey',
                           'Jo',
                           'Josepha',
                           'Josey',
                           'Josie',
                           'Josy',
                           'Pheny'
                         ],
          'Casper' => [
                        'Jasper'
                      ],
          'Beatrice' => [
                          'Bea',
                          'Trisha',
                          'Trissy',
                          'Trix',
                          'Trixie'
                        ],
          'Silas' => [
                       'Si'
                     ],
          'Bertram' => [
                         'Bert'
                       ],
          'Christina' => [
                           'Chris',
                           'Christie',
                           'Crissi',
                           'Crissie',
                           'Crissy',
                           'Kris',
                           'Krissie',
                           'Krissy',
                           'Tina'
                         ],
          'Ryan' => [
                      'Ry'
                    ],
          'Henrietta' => [
                           'Etta',
                           'Hank',
                           'Hattie',
                           'Hatty',
                           'Hennie',
                           'Henny',
                           'Hettie',
                           'Hetty',
                           'Nettie',
                           'Retta'
                         ],
          'Winsley' => [
                         'Win'
                       ],
          'Tanafra' => [
                         'Tanny'
                       ],
          'Susannah' => [
                          'Hannah',
                          'Suchey',
                          'Suchie',
                          'Suchy',
                          'Sudy',
                          'Sue',
                          'Sukey',
                          'Susan',
                          'Susey',
                          'Susie',
                          'Susy',
                          'Suzanne',
                          'Suzey',
                          'Suzie',
                          'Suzy'
                        ],
          'Elvira' => [
                        'Elvie'
                      ],
          'Edna' => [
                      'Edny'
                    ],
          'Anthony' => [
                         'Antoine',
                         'Antoinette',
                         'Antonia',
                         'Antonio',
                         'Tony'
                       ],
          'Stewart' => [
                         'Stu'
                       ],
          'Aristotle' => [
                           'Telley',
                           'Tellie',
                           'Telly'
                         ],
          'Louvenia' => [
                          'Vina',
                          'Viny'
                        ],
          'Elmira' => [
                        'Mira'
                      ],
          'Littleberry' => [
                             'Berry',
                             'Lb',
                             'L.b.',
                             'Little'
                           ],
          'Sylvanus' => [
                          'Sly',
                          'Syl'
                        ],
          'Avarilla' => [
                          'Rilla'
                        ],
          'Rosabella' => [
                           'Rosable'
                         ],
          'Ferdinando' => [
                            'Ferdie',
                            'Fred'
                          ],
          'Nicole' => [
                        'Cole',
                        'Nickie',
                        'Nicki',
                        'Nicky',
                        'Nikki',
                        'Nole'
                      ],
          'Clara' => [
                       'Claire',
                       'Clarice',
                       'Clarissa'
                     ],
          'Pernetta' => [
                          'Nettie'
                        ],
          'Reginald' => [
                          'Reggie',
                          'Reggi',
                          'Reg',
                          'Renaldo',
                          'Rex',
                          'Reynold'
                        ],
          'Joanna' => [
                        'Jane',
                        'Jean',
                        'Joan',
                        'Joannah',
                        'Joanne',
                        'Joann',
                        'Jody',
                        'Johannah',
                        'Johanna',
                        'Noney',
                        'Nonie',
                        'Nony'
                      ],
          'Geraldine' => [
                           'Deanney',
                           'Deannie',
                           'Deanny',
                           'Dina',
                           'Gerey',
                           'Gerie',
                           'Gerrie',
                           'Gerri',
                           'Gerry',
                           'Gery',
                           'Jerry'
                         ],
          'Nanette' => [
                         'Nan'
                       ],
          'Charity' => [
                         'Chat'
                       ],
          'Michelle' => [
                          'Mickey',
                          'Shelly'
                        ],
          'Ariadne' => [
                         'Arie'
                       ],
          'Tyrone' => [
                        'Ty'
                      ],
          'Quince' => [
                        'Quinn',
                        'Quint'
                      ],
          'Jason' => [
                       'Jay'
                     ],
          'Thomasine' => [
                           'Tamzine',
                           'Thomasa'
                         ],
          'Leonard' => [
                         'Lenhart',
                         'Len',
                         'Lenney',
                         'Lennie',
                         'Lenny',
                         'Leo',
                         'Leon',
                         'Lineau'
                       ],
          'Harriet' => [
                         'Harrie',
                         'Harry',
                         'Hattey',
                         'Hattie',
                         'Hatty'
                       ],
          'Alphonse' => [
                          'Al'
                        ],
          'Abner' => [
                       'Ab',
                       'Abbie'
                     ],
          'Augusta' => [
                         'Aggy',
                         'Augey',
                         'Augie',
                         'Augusta',
                         'Augustina',
                         'Augustus',
                         'Augy',
                         'Gusey',
                         'Gusie',
                         'Gussie',
                         'Gusy',
                         'Ina',
                         'Tina'
                       ],
          'Floyd' => [
                       'Lloyd'
                     ],
          'Felicity' => [
                          'Felicia',
                          'Flick',
                          'Tick'
                        ],
          'Keziah' => [
                        'Kezzey',
                        'Kezzie',
                        'Kezzy',
                        'Kid',
                        'Kizza',
                        'Kizzy'
                      ],
          'Eugene' => [
                        'Gene'
                      ],
          'Alicia' => [
                        'Ally'
                      ],
          'Mitzi' => [
                       'Mary'
                     ],
          'Melinda' => [
                         'Linda',
                         'Lindy',
                         'Mel'
                       ],
          'Phoebe' => [
                        'Fifi'
                      ],
          'Gregory' => [
                         'Gregg',
                         'Greg'
                       ],
          'Lurana' => [
                        'Lura'
                      ],
          'Deuteronomy' => [
                             'Duty'
                           ],
          'Augustina' => [
                           'Aggy',
                           'Augie',
                           'Augustus',
                           'Gusie',
                           'Gussie',
                           'Ina',
                           'Tina'
                         ],
          'Tranquilla' => [
                            'Quilla',
                            'Trannie'
                          ],
          'Bedelia' => [
                         'Bridgit',
                         'Delia',
                         'Fidelia'
                       ],
          'Myrtle' => [
                        'Mert',
                        'Myrtey',
                        'Myrtie',
                        'Myrti',
                        'Myrt',
                        'Myrty'
                      ],
          'Chauncy' => [
                         'Chan'
                       ],
          'Cornelia' => [
                          'Conny',
                          'Corney',
                          'Cornie',
                          'Corny',
                          'Neely',
                          'Nelia',
                          'Nelle',
                          'Nelly'
                        ],
          'Jerita' => [
                        'Rita'
                      ],
          'Lewvisa' => [
                         'Vicey',
                         'Vicie',
                         'Vicy'
                       ],
          'Dorinda' => [
                         'Dora',
                         'Dorothea'
                       ],
          'Joshua' => [
                        'Josh'
                      ],
          'Beverly' => [
                         'Bev',
                         'Beverley',
                         'Beverlie',
                         'Beverly'
                       ],
          'Sibbilla' => [
                          'Cibyl',
                          'Sibbell',
                          'Sibbey',
                          'Sibbie',
                          'Sibby',
                          'Sibyl'
                        ],
          'Nadezhda' => [
                          'Nadia'
                        ],
          'Isaac' => [
                       'Ike',
                       'Zeke'
                     ],
          'Rudolphus' => [
                           'Adolf',
                           'Adolphus',
                           'Adoph',
                           'Ado',
                           'Dolf',
                           'Olph',
                           'Rolf',
                           'Rudey',
                           'Rudie',
                           'Rudolph',
                           'Rudy'
                         ],
          'Blanche' => [
                         'Bea'
                       ],
          'Columbus' => [
                          'Clum',
                          'Lum'
                        ],
          'Julia' => [
                       'Jill',
                       'Juley',
                       'Julie',
                       'Juliet',
                       'July'
                     ],
          'Ella' => [
                      'Eleanor',
                      'Gabriella',
                      'Helen',
                      'Luella'
                    ],
          'Vladimir' => [
                          'Volodia'
                        ],
          'Elena' => [
                       'Helen'
                     ],
          'Clifton' => [
                         'Cliff'
                       ],
          'Weston' => [
                        'Wes'
                      ],
          'Jefferson' => [
                           'Geoff',
                           'Geoffrey',
                           'Geoffrie',
                           'Geoffry',
                           'Jeff',
                           'Jeffrey',
                           'Jeffrie',
                           'Jeffry'
                         ],
          'Bethena' => [
                         'Beth',
                         'Thaney'
                       ],
          'Elysia' => [
                        'Lisa'
                      ],
          'Jeffrey' => [
                         'Geoffrey',
                         'Jeff'
                       ],
          'Daniel' => [
                        'Dan',
                        'Danial',
                        'Dank',
                        'Danny'
                      ],
          'Zaven' => [
                       'Zee'
                     ],
          'Phineas' => [
                         'Finney',
                         'Finnie',
                         'Finny'
                       ],
          'Broderick' => [
                           'Bradey',
                           'Bradie',
                           'Brady',
                           'Brodey',
                           'Brodie',
                           'Brody'
                         ],
          'Governor' => [
                          'Govie'
                        ],
          'Danforth' => [
                          'Dan'
                        ],
          'Pheney' => [
                        'Josephine'
                      ],
          'Prudence' => [
                          'Densey',
                          'Densie',
                          'Densy',
                          'Prudey',
                          'Prudie',
                          'Prudy',
                          'Prue',
                          'Pru'
                        ],
          'Roscoe' => [
                        'Ross'
                      ],
          'Lucina' => [
                        'Sinah'
                      ],
          'Frances' => [
                         'Fan',
                         'Fanney',
                         'Fannie',
                         'Fanny',
                         'France',
                         'Francie',
                         'Franci',
                         'Fran',
                         'Franie',
                         'Frankie',
                         'Franz',
                         'Sis'
                       ],
          'Adrienne' => [
                          'Adrian'
                        ],
          'Barry' => [
                       'Bear'
                     ],
          'Terence' => [
                         'Terrie',
                         'Terri',
                         'Terry'
                       ],
          'Malinda' => [
                         'Lindy'
                       ],
          'Mackenzie' => [
                           'Kenzy',
                           'Mack',
                           'Mac'
                         ],
          'Ernst' => [
                       'Ernie'
                     ],
          'Ann' => [
                     'Hannah',
                     'Nana',
                     'Nan',
                     'Nancy',
                     'Nanny',
                     'Susanna'
                   ],
          'Roderik' => [
                         'Eric'
                       ],
          'Carlotta' => [
                          'Carla',
                          'Lottie',
                          'Lotty'
                        ],
          'Theophilus' => [
                            'Ophey',
                            'Ophie',
                            'Ophi',
                            'Ophy'
                          ],
          'Cornelius' => [
                           'Cono',
                           'Neal',
                           'Neely',
                           'Neil',
                           'Niel'
                         ],
          'Mavery' => [
                        'Mave'
                      ],
          'Tennessee' => [
                           'Tenney',
                           'Tennie',
                           'Tenny'
                         ],
          'Eileen' => [
                        'Helen'
                      ],
          'Arlene' => [
                        'Arley',
                        'Arlie',
                        'Arly',
                        'Lena'
                      ],
          'Amelia' => [
                        'Amy',
                        'Emily',
                        'Emmie',
                        'Emmy',
                        'Mel',
                        'Melia',
                        'Millie',
                        'Parmelia',
                        'Permelia'
                      ],
          'Bartholomew' => [
                             'Bart',
                             'Bartel',
                             'Barth',
                             'Bat',
                             'Mees',
                             'Meus'
                           ],
          'Christian' => [
                           'Chris',
                           'Christopher',
                           'Kit'
                         ],
          'Alastair' => [
                          'Al'
                        ],
          'Clarence' => [
                          'Clay'
                        ],
          'Penelope' => [
                          'Neppey',
                          'Neppie',
                          'Neppy',
                          'Penney',
                          'Pennie',
                          'Penny'
                        ],
          'Karonhappuck' => [
                              'Carrie',
                              'Happey',
                              'Happie',
                              'Happy',
                              'Karen',
                              'Karon'
                            ],
          'Priscilla' => [
                           'Cilla',
                           'Ciller',
                           'Cil',
                           'Pris',
                           'Prissey',
                           'Prissie',
                           'Prissy',
                           'Siller'
                         ],
          'Fidelia' => [
                         'Delia'
                       ],
          'Barnard' => [
                         'Barney',
                         'Bernie'
                       ],
          'Inez' => [
                      'Agnes'
                    ],
          'Greenberry' => [
                            'Berry',
                            'Green'
                          ],
          'Gertrude' => [
                          'Gattey',
                          'Gattie',
                          'Gatty',
                          'Gertey',
                          'Gert',
                          'Gertie',
                          'Gerty',
                          'Trudey',
                          'Trudie',
                          'Trudi',
                          'Trudy'
                        ],
          'Leonora' => [
                         'Elenor',
                         'Honor',
                         'Loenore',
                         'Nora'
                       ],
          'Duncan' => [
                        'Dunk'
                      ],
          'Medora' => [
                        'Dora'
                      ],
          'Clarissa' => [
                          'Cissy',
                          'Claire',
                          'Clara',
                          'Clare',
                          'Clarice',
                          'Clarinda'
                        ],
          'Stephan' => [
                         'Steve'
                       ],
          'Onicyphorous' => [
                              'Cy',
                              'Cyphorus',
                              'One',
                              'Osaforum',
                              'Osaforus',
                              'Syphorous'
                            ],
          'Eric' => [
                      'Rick',
                      'Ricky'
                    ],
          'Morton' => [
                        'Mort'
                      ],
          'Napoleon' => [
                          'Leon',
                          'Nap',
                          'Nappey',
                          'Nappie',
                          'Nappy',
                          'Poley',
                          'Poney',
                          'Ponie',
                          'Pony'
                        ],
          'Hermione' => [
                          'Hermey',
                          'Hermie',
                          'Hermoine',
                          'Hermy'
                        ],
          'Marvin' => [
                        'Marv',
                        'Merv',
                        'Mervyn'
                      ],
          'Doris' => [
                       'Dora'
                     ],
          'Jacqueline' => [
                            'Jackie',
                            'Jacklin',
                            'Jacklyn',
                            'Jaclin',
                            'Jaclyn',
                            'Jacque',
                            'Jakey',
                            'Jakie',
                            'Jaky',
                            'Jaqui'
                          ],
          'Jonathan' => [
                          'John',
                          'Jon',
                          'Nathan',
                          'Nat'
                        ],
          'Eurydice' => [
                          'Dicey'
                        ],
          'Jehu' => [
                      'Gee',
                      'Hugh',
                      'Jayhugh'
                    ],
          'Sandra' => [
                        'Alexandra',
                        'Sandy'
                      ],
          'Isadora' => [
                         'Dora',
                         'Issy'
                       ],
          'Kathleen' => [
                          'Cate',
                          'Cathy',
                          'Cat',
                          'Karen',
                          'Kate',
                          'Katharine',
                          'Kathy',
                          'Katie',
                          'Kay',
                          'Kit',
                          'Kittie',
                          'Kitty'
                        ],
          'Selina' => [
                        'Celina'
                      ],
          'Emmanuel' => [
                          'Manny'
                        ],
          'Lawrence' => [
                          'Larrey',
                          'Larrie',
                          'Larry',
                          'Lars',
                          'Laurence',
                          'Laurie',
                          'Lawrey',
                          'Lawrie',
                          'Lawry',
                          'Lon',
                          'Lonney',
                          'Lonnie',
                          'Lonny',
                          'Lorne',
                          'Lorry'
                        ],
          'Carmellia' => [
                           'Mellia'
                         ],
          'Relief' => [
                        'Leafa',
                        'Leafey',
                        'Leafie',
                        'Leafy'
                      ],
          'Sheldon' => [
                         'Shelly',
                         'Shel',
                         'Shelton'
                       ],
          'Persephone' => [
                            'Seph',
                            'Sephy'
                          ],
          'Casey' => [
                       'Kasey',
                       'Kasie',
                       'Kasy',
                       'Kc'
                     ],
          'Anselm' => [
                        'Ance',
                        'Anse',
                        'Ansel',
                        'Selma'
                      ],
          'Eleazer' => [
                         'Lazar'
                       ],
          'Unice' => [
                       'Nicie'
                     ],
          'Elisa' => [
                       'Lisa'
                     ],
          'Noel' => [
                      'Knowell',
                      'Nowell'
                    ],
          'Ramona' => [
                        'Mona'
                      ],
          'Moses' => [
                       'Amos',
                       'Moe',
                       'Mo',
                       'Mose',
                       'Moss'
                     ],
          'Mary' => [
                      'America',
                      'Demaris',
                      'Mae',
                      'Mamey',
                      'Mamie',
                      'Mamy',
                      'Marcia',
                      'Mariah',
                      'Maria',
                      'Marica',
                      'Marie',
                      'Marietta',
                      'Marilyn',
                      'Marion',
                      'Mate',
                      'Maura',
                      'Maureen',
                      'May',
                      'Mercy',
                      'Mimi',
                      'Minnie',
                      'Mitzi',
                      'Moira',
                      'Mollie',
                      'Moll',
                      'Molly',
                      'Polly'
                    ],
          'Ezekiel' => [
                         'Ez',
                         'Zeke'
                       ],
          'Malcolm' => [
                         'Mac',
                         'Malachey',
                         'Malachie',
                         'Malachy',
                         'Malc',
                         'Mal'
                       ],
          'Caldonia' => [
                          'Callie',
                          'Dona'
                        ],
          'Lauren' => [
                        'Laurie',
                        'Ren'
                      ],
          'Valentina' => [
                           'Felty',
                           'Valeda',
                           'Valerey',
                           'Valerie',
                           'Valery',
                           'Valley',
                           'Vallie',
                           'Vally',
                           'Val'
                         ],
          'Salome' => [
                        'Loomie'
                      ],
          'Nadine' => [
                        'Dee dee',
                        'Nada'
                      ],
          'Woodrow' => [
                         'Wood',
                         'Woody'
                       ],
          'Erasmus' => [
                         'Rasmus',
                         'Raze'
                       ],
          'Calvin' => [
                        'Cal'
                      ],
          'Thompson' => [
                          'Tommie',
                          'Tommy',
                          'Tom'
                        ],
          'Lotta' => [
                       'Charlotta',
                       'Charlotte'
                     ],
          'Regina' => [
                        'Gina',
                        'Ray'
                      ],
          'Therese' => [
                         'Terrie',
                         'Terri',
                         'Terry',
                         'Tess'
                       ],
          'Emeline' => [
                         'Emeline',
                         'Em',
                         'Emiline',
                         'Emily',
                         'Emma',
                         'Emm',
                         'Emmer',
                         'Emmey',
                         'Emmie',
                         'Emmy',
                         'Erma',
                         'Lina',
                         'Millie'
                       ],
          'Arzada' => [
                        'Zaddey',
                        'Zaddi',
                        'Zaddie',
                        'Zaddy'
                      ],
          'Derek' => [
                       'Dirk'
                     ],
          'Mckenna' => [
                         'Ken',
                         'Kenna',
                         'Meaka'
                       ],
          'Lucretia' => [
                          'Creasey',
                          'Creasie',
                          'Creasy',
                          'Crece',
                          'Crese'
                        ],
          'Isabellea' => [
                           'Bella',
                           'Belle',
                           'Cybilla',
                           'Elizabeth',
                           'Ib',
                           'Issy',
                           'Nib',
                           'Sabe',
                           'Sabra',
                           'Sibella',
                           'Tibbie'
                         ],
          'Manuel' => [
                        'Emanuel',
                        'Manny'
                      ],
          'Catherine' => [
                           'Cassie',
                           'Cat',
                           'Cate',
                           'Cathy',
                           'Karen',
                           'Kate',
                           'Katharine',
                           'Kathleen',
                           'Kathy',
                           'Katie',
                           'Kay',
                           'Kit',
                           'Kittie',
                           'Kitty',
                           'Rhynie',
                           'Rina',
                           'Rinae',
                           'Trina'
                         ],
          'Faith' => [
                       'Faye',
                       'Fay'
                     ],
          'Caswell' => [
                         'Cass'
                       ],
          'Isabella' => [
                          'Belle',
                          'Ib',
                          'Isabel',
                          'Isabelle',
                          'Nibbey',
                          'Nibbie',
                          'Nibby',
                          'Nib',
                          'Rosabella',
                          'Sabe',
                          'Sabra',
                          'Tibbey',
                          'Tibbie',
                          'Tibby'
                        ],
          'Caleb' => [
                       'Cal'
                     ],
          'Carl' => [
                      'Charles',
                      'Karl'
                    ],
          'Ellen' => [
                       'Helen',
                       'Nell',
                       'Nellie'
                     ],
          'Roderick' => [
                          'Erick',
                          'Eric',
                          'Rickie',
                          'Rod'
                        ],
          'Terrance' => [
                          'Terence',
                          'Terrie',
                          'Terri',
                          'Terry'
                        ],
          'Alexandria' => [
                            'Alexander',
                            'Alexandra',
                            'Alla',
                            'Cassandra',
                            'Drina',
                            'Elic',
                            'Ellie',
                            'Lexa',
                            'Sandra',
                            'Xan'
                          ],
          'Jessie' => [
                        'Jane',
                        'Janet',
                        'Jessica',
                        'Jess'
                      ],
          'Laverne' => [
                         'Verna'
                       ],
          'Levicy' => [
                        'Vicy'
                      ],
          'Jillian' => [
                         'Jill'
                       ],
          'James' => [
                       'Jaime',
                       'Jameson',
                       'Jamie',
                       'Jay',
                       'Jem',
                       'Jim',
                       'Jimmey',
                       'Jimmie',
                       'Jimmy'
                     ],
          'Irvin' => [
                       'Irving'
                     ],
          'Hopkins' => [
                         'Hop',
                         'Hopp'
                       ],
          'Aileen' => [
                        'Helen'
                      ],
          'Isidore' => [
                         'Izzey',
                         'Izzie',
                         'Izzy'
                       ],
          'Victoria' => [
                          'Torey',
                          'Toria',
                          'Torie',
                          'Tori',
                          'Torrey',
                          'Torrie',
                          'Torry',
                          'Tory',
                          'Vickie',
                          'Vicki',
                          'Vicky'
                        ],
          'Leopold' => [
                         'Leo'
                       ],
          'Marjory' => [
                         'Jerri',
                         'Jerry',
                         'Marge',
                         'Marg'
                       ],
          'Roseanne' => [
                          'Roseanna',
                          'Roseann',
                          'Roxane',
                          'Roxanna',
                          'Roxanne',
                          'Roxey',
                          'Roxie',
                          'Rox',
                          'Roxy'
                        ],
          'Josepha' => [
                         'Pheny'
                       ],
          'Letitia' => [
                         'Lettice',
                         'Lettie',
                         'Tish',
                         'Titia'
                       ],
          'Frederica' => [
                           'Erica',
                           'Erika',
                           'Fredricka',
                           'Ricka'
                         ],
          'Jeremiah' => [
                          'Jereme',
                          'Jeremey',
                          'Jeremie',
                          'Jeremy',
                          'Jerry'
                        ],
          'Arthur' => [
                        'Art'
                      ],
          'Armilda' => [
                         'Milly'
                       ],
          'Chesley' => [
                         'Chesley',
                         'Cheslie',
                         'Chesly',
                         'Chet'
                       ],
          'Kayla' => [
                       'Kay-kay'
                     ],
          'Calpurnia' => [
                           'Cally'
                         ],
          'Delpha' => [
                        'Philadelphia'
                      ],
          'Sheridan' => [
                          'Danny',
                          'Dan',
                          'Sher'
                        ],
          'Sanford' => [
                         'Sandy'
                       ],
          'Theotha' => [
                         'Otha'
                       ],
          'Madeline' => [
                          'Lena',
                          'Maddey',
                          'Maddie',
                          'Maddi',
                          'Maddy',
                          'Madeleine',
                          'Madge',
                          'Maggie',
                          'Maud',
                          'Middey',
                          'Middie',
                          'Middy'
                        ],
          'Haseltine' => [
                           'Hassie'
                         ],
          'Bridget' => [
                         'Biddie',
                         'Biddy',
                         'Brey',
                         'Bridgey',
                         'Bridgie',
                         'Bridgy',
                         'Bridie',
                         'Brie',
                         'Bry',
                         'Delia'
                       ],
          'Conrad' => [
                        'Con'
                      ],
          'Lavonia' => [
                         'Vina',
                         'Viney',
                         'Vonnie',
                         'Wyncha'
                       ],
          'Experience' => [
                            'Exie',
                            'Peddey',
                            'Peddie',
                            'Peddy'
                          ],
          'Tiffany' => [
                         'Tiff',
                         'Tiffy'
                       ],
          'Zebulon' => [
                         'Lon',
                         'Zeb'
                       ],
          'Jeanette' => [
                          'Jan',
                          'Jeanne',
                          'Nettie'
                        ],
          'Arielle' => [
                         'Arey',
                         'Arie',
                         'Ary'
                       ],
          'Cleatus' => [
                         'Cleat'
                       ],
          'Elisha' => [
                        'Eli',
                        'Ellis',
                        'Lish'
                      ],
          'Mildred' => [
                         'Mell',
                         'Milly',
                         'Mimi'
                       ],
          'Jehiel' => [
                        'Hiel'
                      ],
          'Mathew' => [
                        'Mat',
                        'Matt',
                        'Matty'
                      ],
          'Philipina' => [
                           'Peney',
                           'Penie',
                           'Peny',
                           'Phililpa',
                           'Phoebe'
                         ],
          'Heather' => [
                         'Hetty'
                       ],
          'Theodore' => [
                          'Dorey',
                          'Ned',
                          'Teddie',
                          'Teddi',
                          'Teddy',
                          'Ted',
                          'Theodorick',
                          'Theodrick',
                          'Theo',
                          'Theotric'
                        ],
          'Sharon' => [
                        'Cheryl',
                        'Sharey',
                        'Sharie',
                        'Sharrey',
                        'Sharrie',
                        'Sharry',
                        'Shar',
                        'Sharyn',
                        'Shary',
                        'Sha',
                        'Shay',
                        'Sherey',
                        'Sherie',
                        'Sheron',
                        'Sheryl',
                        'Sheryn',
                        'Shery'
                      ],
          'Azariah' => [
                         'Azarich',
                         'Aze',
                         'Tiah'
                       ],
          'Herman' => [
                        'Harman'
                      ],
          'Clayton' => [
                         'Clay'
                       ],
          'Aleva' => [
                       'Leve',
                       'Levey',
                       'Levie',
                       'Levy'
                     ],
          'Melvin' => [
                        'Mel'
                      ],
          'Laurence' => [
                          'Larry',
                          'Laurie'
                        ],
          'Montgomery' => [
                            'Gum',
                            'Montesque',
                            'Monty'
                          ],
          'Gordon' => [
                        'Gord',
                        'Gordo'
                      ],
          'Victor' => [
                        'Vick',
                        'Vic'
                      ],
          'Wilda' => [
                       'Willie'
                     ],
          'Aubrey' => [
                        'Bree'
                      ],
          'Raymond' => [
                         'Ray'
                       ],
          'Kristina' => [
                          'Chris',
                          'Christie',
                          'Crissie',
                          'Crissi',
                          'Crissy',
                          'Kris',
                          'Krissie',
                          'Krissy',
                          'Tina'
                        ],
          'Almina' => [
                        'Minnie'
                      ],
          'Beverley' => [
                          'Bev'
                        ],
          'Cassandra' => [
                           'Cass',
                           'Cassey',
                           'Cassie',
                           'Cassy',
                           'Sandi',
                           'Sandra'
                         ],
          'Margarita' => [
                           'Daisy',
                           'Greta',
                           'Madge',
                           'Maggie',
                           'Maisie',
                           'Margauerite',
                           'Marge',
                           'Margo',
                           'Megan',
                           'Meg',
                           'Metta',
                           'Midge',
                           'Peggie',
                           'Rita'
                         ],
          'Carmon' => [
                        'Cammie',
                        'Carm',
                        'Charm'
                      ],
          'Joyce' => [
                       'Joy'
                     ],
          'Felicia' => [
                         'Fel',
                         'Feli'
                       ],
          'Elizabeth' => [
                           'Baisey',
                           'Baisie',
                           'Baissey',
                           'Baissie',
                           'Baissy',
                           'Baisy',
                           'Bess',
                           'Bessey',
                           'Bessie',
                           'Bessy',
                           'Beth',
                           'Bethia',
                           'Betsey',
                           'Betsie',
                           'Betsy',
                           'Bette',
                           'Bettey',
                           'Bettie',
                           'Betty',
                           'Bitsey',
                           'Bitsie',
                           'Bitsy',
                           'Dicey',
                           'Elis',
                           'Elissa',
                           'Eliza',
                           'Elsie',
                           'Ibby',
                           'Libby',
                           'Lib',
                           'Lilabet',
                           'Lilly',
                           'Lise',
                           'Lizabeth',
                           'Liza',
                           'Liz',
                           'Lizzey',
                           'Lizzie',
                           'Lizzy',
                           'Tess'
                         ],
          'Leroy' => [
                       'Lee',
                       'Lr',
                       'Roy',
                       'Roy'
                     ],
          'Junior' => [
                        'Jr',
                        'June',
                        'Juney',
                        'Junie',
                        'Juny'
                      ],
          'Alan' => [
                      'Al'
                    ],
          'Philander' => [
                           'Fie'
                         ],
          'Euphrosina' => [
                            'Fena',
                            'Fenee'
                          ],
          'Martha' => [
                        'Marcy',
                        'Marnie',
                        'Marti',
                        'Mart',
                        'Marty',
                        'Mat',
                        'Mattie',
                        'Matty',
                        'Patsy',
                        'Patty'
                      ],
          'Audrey' => [
                        'Dee'
                      ],
          'Vanessa' => [
                         'Essa',
                         'Nessa',
                         'Vanna',
                         'Vanney',
                         'Vannie',
                         'Vanny',
                         'Van'
                       ],
          'Dominic' => [
                         'Dom',
                         'Nick',
                         'Nickie',
                         'Nicky'
                       ],
          'Russell' => [
                         'Russ',
                         'Rustey',
                         'Rustie',
                         'Rusty'
                       ],
          'Harold' => [
                        'Hal',
                        'Harry'
                      ],
          'Elwood' => [
                        'Ells',
                        'Elly'
                      ],
          'Pelegrine' => [
                           'Perrey',
                           'Perrie',
                           'Perry'
                         ],
          'Waitstill' => [
                           'Waitey',
                           'Waitie',
                           'Waity'
                         ],
          'Royall' => [
                        'Roy'
                      ],
          'Tabitha' => [
                         'Tabbey',
                         'Tabbie',
                         'Tabby'
                       ],
          'Agatha' => [
                        'Addy',
                        'Ag',
                        'Aggie',
                        'Aggy',
                        'Agnes'
                      ],
          'Corey' => [
                       'Coco',
                       'Cordy',
                       'Ree'
                     ],
          'Desdemona' => [
                           'Mona'
                         ],
          'Ignatzio' => [
                          'Iggy',
                          'Nace',
                          'Naz'
                        ],
          'Augustus' => [
                          'Augusta',
                          'Augustine',
                          'Gatsbey',
                          'Gatsbie',
                          'Gatsby',
                          'Gatsey',
                          'Gatsie',
                          'Gatsy',
                          'Gus',
                          'Gustie',
                          'Gustus'
                        ],
          'Della' => [
                       'Adela',
                       'Adelaide',
                       'Delilah'
                     ],
          'Fitzgerald' => [
                            'Fitz',
                            'Fitzie',
                            'Fitzy'
                          ],
          'Antoinette' => [
                            'Antonia',
                            'Net',
                            'Netta',
                            'Nettie',
                            'Netty',
                            'Toni',
                            'Tonie',
                            'Tony'
                          ],
          'Eunice' => [
                        'Nicie'
                      ],
          'Stephanie' => [
                           'Annie',
                           'Steffie',
                           'Stephie',
                           'Steph'
                         ],
          'Valentine' => [
                           'Felty',
                           'Vallie',
                           'Val'
                         ],
          'Thaddeus' => [
                          'Tad',
                          'Thad'
                        ],
          'Rodney' => [
                        'Roddey',
                        'Roddie',
                        'Roddy'
                      ],
          'Delores' => [
                         'Dee',
                         'Dodie',
                         'Lola'
                       ],
          'Deidre' => [
                        'Deedee'
                      ],
          'Rhodella' => [
                          'Della',
                          'Rhoda',
                          'Rhodey',
                          'Rhodie',
                          'Rhody'
                        ],
          'Alexandra' => [
                           'Alex',
                           'Allie',
                           'Ally',
                           'Lexa',
                           'Sandi',
                           'Sandie',
                           'Sandy',
                           'Xan'
                         ],
          'Allan' => [
                       'Al'
                     ],
          'Gillian' => [
                         'Jill'
                       ],
          'John' => [
                      'Hans',
                      'Ian',
                      'Ivan',
                      'Jack',
                      'Jackson',
                      'Jaques',
                      'Jayhugh',
                      'Jay',
                      'Jean',
                      'Jehu',
                      'Jock'
                    ],
          'Silvester' => [
                           'Si',
                           'Sly',
                           'Syl',
                           'Vester',
                           'Vest'
                         ],
          'Kendra' => [
                        'Kay',
                        'Kenjey',
                        'Kenjie',
                        'Kenji',
                        'Kenj',
                        'Kenjy',
                        'Kenny'
                      ],
          'Dorothy' => [
                         'Dee',
                         'Doda',
                         'Dode',
                         'Dolley',
                         'Dollie',
                         'Dolly',
                         'Dora',
                         'Dorinda',
                         'Doris',
                         'Dorothea',
                         'Dortha',
                         'Dot',
                         'Dotha',
                         'Dottey',
                         'Dottie',
                         'Dotty',
                         'Medora'
                       ],
          'Jessica' => [
                         'Jesse',
                         'Jessie',
                         'Jess',
                         'Jessy',
                         'Sica'
                       ],
          'Jinsy' => [
                       'Jane'
                     ],
          'Hilda' => [
                       'Hillie',
                       'Hilly'
                     ],
          'Solomon' => [
                         'Salmon',
                         'Sal',
                         'Saul',
                         'Solley',
                         'Sollie',
                         'Solly',
                         'Sol',
                         'Zolley',
                         'Zollie',
                         'Zolly'
                       ],
          'Kristine' => [
                          'Chris',
                          'Christie',
                          'Crissie',
                          'Crissi',
                          'Crissy',
                          'Kissy',
                          'Kris',
                          'Krissie',
                          'Krissy'
                        ],
          'Phillip' => [
                         'Phip',
                         'Pip'
                       ],
          'Jennet' => [
                        'Jenny',
                        'Jessie'
                      ],
          'Tomas' => [
                       'Tommie',
                       'Tommy',
                       'Tom'
                     ],
          'Curtis' => [
                        'Curt',
                        'Kurt',
                        'Kurtis'
                      ],
          'Judson' => [
                        'Jud'
                      ],
          'Vivian' => [
                        'Vi',
                        'Viv'
                      ],
          'Archilles' => [
                           'Kill',
                           'Killis'
                         ],
          'Tryphosia' => [
                           'Phosey',
                           'Phosie',
                           'Phosy'
                         ],
          'Edison' => [
                        'Ed'
                      ],
          'Morris' => [
                        'Moe',
                        'Mo',
                        'Morrie',
                        'Morry'
                      ],
          'Libuse' => [
                        'Liba'
                      ],
          'Rosina' => [
                        'Sina'
                      ],
          'Crawford' => [
                          'Ford',
                          'Fordy'
                        ],
          'Irving' => [
                        'Irv'
                      ],
          'Diane' => [
                       'Dicey',
                       'Di',
                       'Didi'
                     ],
          'Nora' => [
                      'Nonie'
                    ],
          'Elminie' => [
                         'Minnie'
                       ],
          'Katrina' => [
                         'Trina'
                       ],
          'Kathyn' => [
                        'Kate'
                      ],
          'Salvador' => [
                          'Sal'
                        ],
          'Cicely' => [
                        'Cilla'
                      ],
          'Lilian' => [
                        'Lilly',
                        'Lily'
                      ],
          'Elias' => [
                       'Eli',
                       'Lias'
                     ],
          'Amanda' => [
                        'Amy',
                        'Armanda',
                        'Manda',
                        'Mandana',
                        'Mandy'
                      ],
          'Millicent' => [
                           'Milly'
                         ],
          'Samantha' => [
                          'Etc.',
                          'Mantha',
                          'Sammy'
                        ],
          'Lotty' => [
                       'Charlotta',
                       'Charlotte'
                     ],
          'Gerard' => [
                        'Gerry',
                        'Jerry'
                      ],
          'Elnora' => [
                        'Nora'
                      ],
          'Willis' => [
                        'Bill',
                        'Willie',
                        'Willy'
                      ],
          'Lavonne' => [
                         'Von'
                       ],
          'Andrew' => [
                        'Andrea',
                        'Andy',
                        'Ansey',
                        'Dew',
                        'Dre',
                        'Drew'
                      ],
          'Maryanne' => [
                          'Marianna',
                          'Maryanna'
                        ],
          'Donald' => [
                        'Don',
                        'Donney',
                        'Donnie',
                        'Donny'
                      ],
          'Roderic' => [
                         'Eric'
                       ],
          'Wilhelmina' => [
                            'Billie',
                            'Helmey',
                            'Helmie',
                            'Helmy',
                            'Mina',
                            'Minnie',
                            'Willie',
                            'Wilma'
                          ],
          'Allison' => [
                         'Allie',
                         'Ally'
                       ],
          'Rhoda' => [
                       'Rodie'
                     ],
          'Cinderella' => [
                            'Arilla',
                            'Cindy',
                            'Rella',
                            'Rilla'
                          ],
          'Alzada' => [
                        'Zada'
                      ],
          'Crystal' => [
                         'Chris',
                         'Etc.'
                       ],
          'Florence' => [
                          'Flo',
                          'Flora',
                          'Florrie',
                          'Flossey',
                          'Floss',
                          'Flossie',
                          'Flossy'
                        ],
          'Courtney' => [
                          'Corky',
                          'Court',
                          'Curt'
                        ],
          'Ellender' => [
                          'Ellen',
                          'Helen',
                          'Nellie'
                        ],
          'Yulan' => [
                       'Lan',
                       'Yul'
                     ],
          'Zepaniah' => [
                          'Zeph'
                        ],
          'Agnes' => [
                       'Aggy',
                       'Ann',
                       'Inez',
                       'Nancy',
                       'Nessey',
                       'Nessie',
                       'Nessy'
                     ],
          'Tryphena' => [
                          'Phena',
                          'Pheobe',
                          'Phoeney',
                          'Phoenie',
                          'Phoeny'
                        ],
          'Carolyn' => [
                         'Caddie',
                         'Carol',
                         'Carrie',
                         'Cassie',
                         'Lena',
                         'Lyn',
                         'Lynn'
                       ],
          'Vernisee' => [
                          'Nicey',
                          'Nicie',
                          'Nicy'
                        ],
          'Annabelle' => [
                           'Belle'
                         ],
          'Celinda' => [
                         'Linda',
                         'Lindy',
                         'Lynn'
                       ],
          'Jedediah' => [
                          'Diah',
                          'Dyer',
                          'Jeb',
                          'Jedidiah',
                          'Jed'
                        ],
          'Edwin' => [
                       'Ed',
                       'Win'
                     ],
          'Jincy' => [
                       'Jane'
                     ],
          'Cordelia' => [
                          'Cordey',
                          'Cordie',
                          'Cordy',
                          'Delia'
                        ],
          'Boetius' => [
                         'Bo'
                       ],
          'Tyson' => [
                       'Ty'
                     ],
          'Peter' => [
                       'Pete'
                     ],
          'California' => [
                            'Callie'
                          ],
          'Malachi' => [
                         'Mally'
                       ],
          'Sibbilla,sibbell,sybill' => [
                                         'Sibbie'
                                       ],
          'Thomas' => [
                        'Thom',
                        'Tomar',
                        'Tommey',
                        'Tommie',
                        'Tommy',
                        'Tom'
                      ],
          'Eliphalet' => [
                           'Eliphal',
                           'Falley',
                           'Fallie',
                           'Fally'
                         ],
          'Eduardo' => [
                         'Ed'
                       ],
          'Edson' => [
                       'Ed'
                     ],
          'Christine' => [
                           'Chris',
                           'Christie',
                           'Christy',
                           'Crissi',
                           'Crissie',
                           'Crissy',
                           'Ina',
                           'Kris',
                           'Krissie',
                           'Krissy',
                           'Tina',
                           'Xina'
                         ],
          'Clementine' => [
                            'Clem'
                          ],
          'Gerhardt' => [
                          'Gay'
                        ],
          'Mehitabel' => [
                           'Amabel',
                           'Hetty',
                           'Hittey',
                           'Hittie',
                           'Hitty',
                           'Mabel',
                           'Mehetabel',
                           'Mehetable',
                           'Mehitable',
                           'Mitty'
                         ],
          'Christiana' => [
                            'Chris',
                            'Christey',
                            'Christie',
                            'Christina',
                            'Christine',
                            'Christy',
                            'Cris',
                            'Crissey',
                            'Crissie',
                            'Crissy',
                            'Cristina',
                            'Ina',
                            'Kerstey',
                            'Kerstie',
                            'Kersty',
                            'Kris',
                            'Kristey',
                            'Kristie',
                            'Kristine',
                            'Kristy',
                            'Tina',
                            'Xena',
                            'Xina'
                          ],
          'Amos' => [
                      'Moses'
                    ],
          'Alphinias' => [
                           'Alphus',
                           'Aphinius',
                           'Finnius',
                           'Phineas'
                         ],
          'Philadelphia' => [
                              'Delpha',
                              'Delphia'
                            ],
          'Denise' => [
                        'Denys',
                        'Denyse'
                      ],
          'Roland' => [
                        'Lanney',
                        'Lannie',
                        'Lanny',
                        'Orlando',
                        'Rolley',
                        'Rollie',
                        'Rolly',
                        'Rowland'
                      ],
          'Cedrick' => [
                         'Ced'
                       ],
          'Prescott' => [
                          'Pres',
                          'Scottey',
                          'Scottie',
                          'Scott',
                          'Scotty'
                        ],
          'Joseph' => [
                        'Joe',
                        'Joey',
                        'Josefa'
                      ],
          'Dalton' => [
                        'Dahl',
                        'Dal'
                      ],
          'Ignatius' => [
                          'Iggey',
                          'Iggie',
                          'Iggy',
                          'Nace',
                          'Natius',
                          'Naz'
                        ],
          'Minerva' => [
                         'Mina',
                         'Minnie',
                         'Nerva',
                         'Nervie'
                       ],
          'Arminda' => [
                         'Mindie'
                       ],
          'Anna' => [
                      'Annette',
                      'Hannah',
                      'Nana',
                      'Nan',
                      'Nancy',
                      'Nanny',
                      'Susanna'
                    ],
          'Artemus' => [
                         'Art'
                       ],
          'Louvinia' => [
                          'Vina',
                          'Viney',
                          'Vonnie',
                          'Wyncha'
                        ],
          'Elsie' => [
                       'Alice',
                       'Elizabeth'
                     ],
          'Lois' => [
                      'Heloise',
                      'Louise'
                    ],
          'Mercedes' => [
                          'Merci',
                          'Mercy',
                          'Sadie'
                        ],
          'Gloria' => [
                        'Glorey',
                        'Glorie',
                        'Glory'
                      ],
          'Nathan' => [
                        'Nat'
                      ],
          'Caroline' => [
                          'Caddey',
                          'Caddie',
                          'Caddy',
                          'Carol',
                          'Carole',
                          'Carolina',
                          'Carolyn',
                          'Carrie',
                          'Cassie',
                          'Karey',
                          'Karie',
                          'Kary',
                          'Kerey',
                          'Kerie',
                          'Kery',
                          'Kim',
                          'Lena',
                          'Lynn',
                          'Orolia'
                        ],
          'Gennifer' => [
                          'Genny'
                        ],
          'Thomasa' => [
                         'Tamzine'
                       ],
          'Mahala' => [
                        'Haley',
                        'Huldah'
                      ],
          'Calista' => [
                         'Kissey',
                         'Kissie',
                         'Kissy'
                       ],
          'Edgar' => [
                       'Ed',
                       'Ned'
                     ],
          'Eudoris' => [
                         'Dosey',
                         'Dosie',
                         'Dossey',
                         'Dossie',
                         'Dossy',
                         'Dosy'
                       ],
          'Violet' => [
                        'Viola'
                      ],
          'Maximillian' => [
                             'Max'
                           ],
          'Susan' => [
                       'Sue',
                       'Suzie',
                       'Suzi',
                       'Suzy'
                     ],
          'Melissa' => [
                         'Alyssa',
                         'Elizabeth',
                         'Lisa',
                         'Lissa',
                         'Mel',
                         'Milly',
                         'Missa',
                         'Missy'
                       ],
          'Esther' => [
                        'Essie',
                        'Hester'
                      ],
          'Andre' => [
                       'Dre'
                     ],
          'Jayme' => [
                       'Jay'
                     ],
          'Eliphalel' => [
                           'Life'
                         ],
          'Barticus' => [
                          'Bart'
                        ],
          'Sydney' => [
                        'Sid'
                      ],
          'Newton' => [
                        'Newt'
                      ],
          'Electra' => [
                         'Electa',
                         'Lecta'
                       ],
          'Vincent' => [
                         'Vince',
                         'Vinnie',
                         'Vinny',
                         'Vinson',
                         'Vin'
                       ],
          'Raymund' => [
                         'Ray'
                       ],
          'Brenda' => [
                        'Brandy'
                      ],
          'Marilyn' => [
                         'Lyn',
                         'Lynn',
                         'Mary'
                       ],
          'Royal' => [
                       'Roy'
                     ],
          'Jannett' => [
                         'Nettie'
                       ],
          'Erwin' => [
                       'Irwin'
                     ],
          'Benjamin' => [
                          'Ben',
                          'Benjey',
                          'Benjie',
                          'Benjy',
                          'Bennie',
                          'Jamie'
                        ],
          'Manola' => [
                        'Nonnie'
                      ],
          'Virginia' => [
                          'Gina',
                          'Ginger',
                          'Ginney',
                          'Ginnie',
                          'Ginny',
                          'Jane',
                          'Jennie',
                          'Jenny',
                          'Jiney',
                          'Jinie',
                          'Jiny',
                          'Vergey',
                          'Vergie',
                          'Vergy',
                          'Virgey',
                          'Virgie',
                          'Virgy'
                        ],
          'Absalom' => [
                         'Ab',
                         'Abbie'
                       ],
          'Frederick' => [
                           'Derick',
                           'Eric',
                           'Freddie',
                           'Freddy',
                           'Fred',
                           'Fredric',
                           'Frish',
                           'Fritz'
                         ],
          'Maureen' => [
                         'Mary',
                         'Maura'
                       ],
          'Arabella' => [
                          'Anabelle',
                          'Ara',
                          'Arabelle',
                          'Bella',
                          'Belle'
                        ],
          'Allen' => [
                       'Al'
                     ],
          'Katarina' => [
                          'Catherine',
                          'Tina',
                          'Trina'
                        ],
          'Ronald' => [
                        'Ronnie',
                        'Ronni',
                        'Ronny',
                        'Ron'
                      ],
          'Eustacia' => [
                          'Stacia',
                          'Stacy'
                        ],
          'Melody' => [
                        'Lodey',
                        'Lodie',
                        'Lodi',
                        'Lody'
                      ],
          'Manoah' => [
                        'Noah'
                      ],
          'Madeleine' => [
                           'Maddie',
                           'Maddi',
                           'Maddy'
                         ],
          'Randolph' => [
                          'Dolph',
                          'Rafe',
                          'Randall',
                          'Randy'
                        ],
          'Valerie' => [
                         'Val'
                       ],
          'Derrick' => [
                         'Dirch',
                         'Eric'
                       ],
          'Winton' => [
                        'Wint'
                      ],
          'Permelia' => [
                          'Mellie',
                          'Melly',
                          'Milly'
                        ],
          'Griselda' => [
                          'Grissel'
                        ],
          'Yvonne' => [
                        'Vonna'
                      ],
          'Bernard' => [
                         'Barney',
                         'Barnie',
                         'Bernie'
                       ],
          'Bazaleel' => [
                          'Basil'
                        ],
          'Almena' => [
                        'Allie',
                        'Mena'
                      ],
          'Hepsabeth' => [
                           'Hepsy'
                         ],
          'Patricia' => [
                          'Pat',
                          'Patsy',
                          'Patty',
                          'Tish',
                          'Tricia',
                          'Trish',
                          'Trixie'
                        ],
          'Norbert' => [
                         'Norbey',
                         'Norbie',
                         'Norby'
                       ],
          'Jasper' => [
                        'Casper',
                        'Jap'
                      ],
          'Veronica' => [
                          'Franky',
                          'Ronna',
                          'Ronnie',
                          'Ronni',
                          'Ronny',
                          'Ron',
                          'Vonney',
                          'Vonnie',
                          'Vonny'
                        ],
          'Richard' => [
                         'Diccon',
                         'Dickie',
                         'Dickon',
                         'Dick',
                         'Dickson',
                         'Dicky',
                         'Richie',
                         'Rich',
                         'Richy',
                         'Rick',
                         'Ritchie'
                       ],
          'Augustine' => [
                           'Augusta',
                           'Gus',
                           'Gustie',
                           'Gustus'
                         ],
          'Gwendolyn' => [
                           'Genny',
                           'Gwen',
                           'Wendey',
                           'Wendie',
                           'Wendy'
                         ],
          'Belinda' => [
                         'Bell',
                         'Belle',
                         'Linda',
                         'Lyn'
                       ],
          'David' => [
                       'Dave',
                       'Davey',
                       'Davie',
                       'Davy',
                       'Day'
                     ],
          'Philip' => [
                        'Filip',
                        'Phil',
                        'Pip'
                      ],
          'Tristram' => [
                          'Tris'
                        ],
          'Theodora' => [
                          'Dora',
                          'Teddie',
                          'Teddi',
                          'Teddy'
                        ],
          'Edith' => [
                       'Dicey',
                       'Edie',
                       'Edna',
                       'Edney',
                       'Ednie',
                       'Edny'
                     ],
          'Sondra' => [
                        'Dre',
                        'Sonnie'
                      ],
          'Winifred' => [
                          'Freddie',
                          'Wenefred',
                          'Winnet',
                          'Winnie',
                          'Winny'
                        ],
          'Percival' => [
                          'Perce',
                          'Percey',
                          'Percie',
                          'Percy'
                        ],
          'Armanda' => [
                         'Mandy'
                       ],
          'Jane' => [
                      'Janet',
                      'Janette',
                      'Janett',
                      'Janey',
                      'Janice',
                      'Janiece',
                      'Janie',
                      'Janyce',
                      'Jany',
                      'Jayce',
                      'Jc',
                      'Jeanne',
                      'Jenny',
                      'Jessie',
                      'Jincey',
                      'Jincie',
                      'Jincy',
                      'Jinsey',
                      'Joan',
                      'Joanna',
                      'Virginia'
                    ],
          'Anastasia' => [
                           'Ana',
                           'Stacy'
                         ],
          'Patrick' => [
                         'Paddey',
                         'Paddie',
                         'Paddy',
                         'Pat',
                         'Patricia',
                         'Patsy',
                         'Peter',
                         'Rick'
                       ],
          'Mary elizabeth' => [
                                'Bibbit'
                              ],
          'Johannes' => [
                          'John',
                          'Johnny',
                          'Jonathan'
                        ],
          'Henry' => [
                       'Hal',
                       'Hank',
                       'Harry',
                       'Hence',
                       'Hen'
                     ],
          'Marcia' => [
                        'Marcie',
                        'Marci',
                        'Marcy'
                      ],
          'Arthusa' => [
                         'Thursa'
                       ],
          'Pheriba' => [
                         'Ferbie',
                         'Pherbia'
                       ],
          'Wilfred' => [
                         'Fred',
                         'Willie',
                         'Will',
                         'Willy'
                       ],
          'Marissa' => [
                         'Rissa'
                       ],
          'Helen' => [
                       'Aileen',
                       'Eileen',
                       'Elaine',
                       'Eleanor',
                       'Ellen',
                       'Lena',
                       'Nell',
                       'Nellie'
                     ],
          'Aurilla' => [
                         'Ora',
                         'Ree',
                         'Rilly'
                       ],
          'Delphine' => [
                          'Del',
                          'Delf',
                          'Delphi'
                        ],
          'Aphrodite' => [
                           'Dite',
                           'Ditus',
                           'Dyce',
                           'Dyche',
                           'Epaphroditius',
                           'Epaphroditus',
                           'Eppa'
                         ],
          'Alexander' => [
                           'Ala',
                           'Al',
                           'Alec',
                           'Alex',
                           'Alexis',
                           'Andi',
                           'Ec',
                           'Eleck',
                           'Sandra',
                           'Sandy',
                           'Xandra',
                           'Zander'
                         ],
          'Demerias' => [
                          'Damaris',
                          'Dea',
                          'Demaris',
                          'Dimmis',
                          'Maris',
                          'Mary'
                        ],
          'Serilla' => [
                         'Rilla'
                       ],
          'Pinckney' => [
                          'Pink'
                        ],
          'Philetus' => [
                          'Leet'
                        ],
          'Artelepsa' => [
                           'Epsey'
                         ],
          'Justin' => [
                        'Justus'
                      ],
          'Irene' => [
                       'Rena',
                       'Rennie'
                     ],
          'Adelbert' => [
                          'Albert',
                          'Bert',
                          'Del',
                          'Delbert'
                        ],
          'Submit' => [
                        'Mitty'
                      ],
          'Leslie' => [
                        'Les',
                        'Lester'
                      ],
          'Judah' => [
                       'Jude',
                       'Juder'
                     ],
          'Horace' => [
                        'Harry',
                        'Horatio',
                        'Horrey',
                        'Horrie',
                        'Horry'
                      ],
          'Mariah' => [
                        'Maria',
                        'Mary'
                      ],
          'Cory' => [
                      'Coco',
                      'Cordy',
                      'Ree'
                    ],
          'Pocahontas' => [
                            'Pokey',
                            'Pokie',
                            'Poky'
                          ],
          'Micajah' => [
                         'Cage',
                         'Cager'
                       ],
          'Kathryn' => [
                         'Cate',
                         'Cathy',
                         'Cat',
                         'Kathy',
                         'Kay',
                         'Kit',
                         'Kittie',
                         'Kitty'
                       ],
          'Shirley' => [
                         'Shirl'
                       ],
          'Rosalyn' => [
                         'Rosalinda',
                         'Rosa',
                         'Rose'
                       ],
          'Rachel' => [
                        'Raech',
                        'Rae',
                        'Ray'
                      ],
          'Immanuel' => [
                          'Emmanuel',
                          'Manuel'
                        ],
          'Sophronia' => [
                           'Frona',
                           'Fronia',
                           'Sophey',
                           'Sophia',
                           'Sophie',
                           'Sophy'
                         ],
          'Irwin' => [
                       'Erwin'
                     ],
          'Araminta' => [
                          'Middie',
                          'Minty',
                          'Ruminta'
                        ],
          'Adolphus' => [
                          'Ado',
                          'Adolph',
                          'Dolph'
                        ],
          'Andrea' => [
                        'Andrew',
                        'Andria',
                        'Drea',
                        'Rea'
                      ],
          'Dennis' => [
                        'Denney',
                        'Dennie',
                        'Dennison',
                        'Denny'
                      ],
          'Hannah' => [
                        'Anna',
                        'Hattie',
                        'Nan',
                        'Nanny',
                        'Susannah'
                      ],
          'Nicodemus' => [
                           'Nick'
                         ],
          'Sabrina' => [
                         'Brina',
                         'Bri',
                         'Sabby',
                         'Sabra',
                         'Serena',
                         'Sybrina'
                       ],
          'Samuel' => [
                        'Samantha',
                        'Sammey',
                        'Sammie',
                        'Sammy',
                        'Sam',
                        'Sonny'
                      ],
          'Mortimer' => [
                          'Mort'
                        ],
          'Lauryn' => [
                        'Laurey',
                        'Laurie',
                        'Laury'
                      ],
          'Deanne' => [
                        'Ann',
                        'Dee'
                      ],
          'Bengtha' => [
                         'Ben'
                       ],
          'Mahalla' => [
                         'Halley',
                         'Hallie',
                         'Hally'
                       ],
          'Zedediah' => [
                          'Zed'
                        ],
          'Elijah' => [
                        'Eli',
                        'Lige',
                        'Lig'
                      ],
          'Sarina' => [
                        'Rena',
                        'Rina'
                      ],
          'Silence' => [
                         'Liley'
                       ],
          'Hepsabel' => [
                          'Hepsy'
                        ],
          'Alanson' => [
                         'Al',
                         'Alan',
                         'Lanson',
                         'Lonson'
                       ],
          'Nicholas' => [
                          'Claas',
                          'Claes',
                          'Etc.',
                          'Nickie',
                          'Nick',
                          'Nicky',
                          'Nicodemus'
                        ],
          'Jacob' => [
                       'Jaap',
                       'Jacobus',
                       'Jake',
                       'Jay'
                     ],
          'Jacques' => [
                         'Jock'
                       ],
          'Ephraim' => [
                         'Eph'
                       ],
          'Petronella' => [
                            'Nellie'
                          ],
          'George' => [
                        'Jorge'
                      ],
          'Celeste' => [
                         'Celia',
                         'Lessey',
                         'Lessie',
                         'Lessy'
                       ],
          'Nathalie' => [
                          'Nat'
                        ],
          'Matthias' => [
                          'Mat',
                          'Matt',
                          'Matty'
                        ],
          'Jerold' => [
                        'Jerry'
                      ],
          'Julias' => [
                        'Jule',
                        'Julian',
                        'Julius'
                      ],
          'Corinne' => [
                         'Cora',
                         'Ora'
                       ],
          'Catrina' => [
                         'Trina'
                       ],
          'Rochelle' => [
                          'Chellie',
                          'Shellie',
                          'Shelly'
                        ],
          'Edward' => [
                        'Eddey',
                        'Eddie',
                        'Eddy',
                        'Ed',
                        'Edgar',
                        'Edmund',
                        'Ned',
                        'Teddi',
                        'Teddie',
                        'Teddy',
                        'Ted'
                      ],
          'Marsha' => [
                        'Marcie',
                        'Marci',
                        'Marcy',
                        'Mary'
                      ],
          'Chauncey' => [
                          'Chance'
                        ],
          'Deliverance' => [
                             'Delley',
                             'Dellie',
                             'Delly',
                             'Dilley',
                             'Dillie',
                             'Dilly'
                           ],
          'Paulina' => [
                         'Paula',
                         'Pauline'
                       ],
          'Celia' => [
                       'Cece',
                       'Sissy'
                     ],
          'America' => [
                         'Mec'
                       ],
          'Roger' => [
                       'Hodgekin',
                       'Hodge',
                       'Rodger',
                       'Roge'
                     ],
          'Webster' => [
                         'Webb'
                       ],
          'Maximilian' => [
                            'Max'
                          ],
          'Lorinda' => [
                         'Laura'
                       ],
          'Pamela' => [
                        'Pam'
                      ],
          'Obadiah' => [
                         'Diah',
                         'Dyer',
                         'Obed',
                         'Obe',
                         'Obie'
                       ],
          'Oswald' => [
                        'Ossey',
                        'Ossie',
                        'Ossy',
                        'Ozzey',
                        'Ozzie',
                        'Ozzy',
                        'Waldo'
                      ],
          'Armida' => [
                        'Middie',
                        'Minty',
                        'Ruminta'
                      ],
          'Mavine' => [
                        'Mave',
                        'Maverey',
                        'Maverie',
                        'Mavery'
                      ],
          'Kenneth' => [
                         'Kendall',
                         'Kendrick',
                         'Ken',
                         'Kenney',
                         'Kennie',
                         'Kenny',
                         'Kent'
                       ],
          'Douglas' => [
                         'Doug'
                       ],
          'Luella' => [
                        'Ella',
                        'Lula'
                      ],
          'Monet' => [
                       'Nettie'
                     ],
          'Egbert' => [
                        'Bert',
                        'Burt'
                      ],
          'Lucille' => [
                         'Ceall',
                         'Cille',
                         'Lou',
                         'Lucie',
                         'Luci',
                         'Lucy'
                       ],
          'Sampson' => [
                         'Sam',
                         'Samson'
                       ],
          'Lunetta' => [
                         'Nettie'
                       ],
          'Lecurgus' => [
                          'Curg'
                        ],
          'Shaina' => [
                        'Sha',
                        'Sha-sha',
                        'Shay'
                      ],
          'Herbert' => [
                         'Bert',
                         'Burt',
                         'Herb'
                       ],
          'Aaron' => [
                       'Erin',
                       'Ron'
                     ],
          'Gabriel' => [
                         'Gabby',
                         'Gabe'
                       ],
          'Gerald' => [
                        'Gerry',
                        'Jerry'
                      ],
          'Eseneth' => [
                         'Seney',
                         'Senie',
                         'Seny'
                       ],
          'Jemima' => [
                        'Jemma',
                        'Mima',
                        'Mimi'
                      ],
          'Steven' => [
                        'Steve'
                      ],
          'Philomena' => [
                           'Almena',
                           'Mena'
                         ],
          'Adelphia' => [
                          'Delphina',
                          'Philley',
                          'Phillie',
                          'Philly'
                        ],
          'Marian' => [
                        'Marianna'
                      ],
          'Malissa' => [
                         'Elizabeth',
                         'Missa'
                       ],
          'Yolanda' => [
                         'Yolonda'
                       ],
          'Juanita' => [
                         'Nita'
                       ],
          'Julian' => [
                        'Jules'
                      ],
          'Jackson' => [
                         'Jack'
                       ],
          'Hillary' => [
                         'Hillie',
                         'Hilly'
                       ],
          'Abigail' => [
                         'Abbey',
                         'Abbie',
                         'Abby',
                         'Abie',
                         'Gail',
                         'Nabbey',
                         'Nabbie',
                         'Nabby'
                       ],
          'Cyrus' => [
                       'Cy'
                     ],
          'Louise' => [
                        'Eliza',
                        'Eloise',
                        'Lois',
                        'Lou',
                        'Lulu'
                      ],
          'Francine' => [
                          'Francie',
                          'Franci',
                          'Fran'
                        ],
          'Alfreda' => [
                         'Alfred',
                         'Alfy',
                         'Frieda'
                       ],
          'India' => [
                       'Indey',
                       'Indie',
                       'Indy'
                     ],
          'Marianna' => [
                          'Mia'
                        ],
          'Winthrop' => [
                          'Win'
                        ],
          'Clifford' => [
                          'Cliff',
                          'Ford'
                        ],
          'Vandalia' => [
                          'Vannie'
                        ],
          'Alvin' => [
                       'Al'
                     ],
          'Magdalena' => [
                           'Lena',
                           'Maggie'
                         ],
          'Martin' => [
                        'Marty'
                      ],
          'Gabrielle' => [
                           'Ella',
                           'Gabbie',
                           'Gabby',
                           'Gabriella'
                         ],
          'Orphelia' => [
                          'Phelia'
                        ],
          'Constance' => [
                           'Connie',
                           'Conny'
                         ],
          'Rebecca' => [
                         'Becca',
                         'Becka',
                         'Beckey',
                         'Beckie',
                         'Beck',
                         'Becky',
                         'Reba'
                       ],
          'Darlene' => [
                         'Darrey',
                         'Darrie',
                         'Darry'
                       ],
          'Lucas' => [
                       'Luke'
                     ],
          'Lucias' => [
                        'Lucas',
                        'Luke'
                      ],
          'Antony' => [
                        'Tony'
                      ],
          'Tobias' => [
                        'Bias',
                        'Tobe',
                        'Tobey',
                        'Tobie',
                        'Tobi',
                        'Toby'
                      ],
          'Almira' => [
                        'Myra'
                      ],
          'Louis' => [
                       'Lewis',
                       'Louie',
                       'Lou'
                     ],
          'Demaris' => [
                         'Dea',
                         'Maris',
                         'Mary'
                       ],
          'Hezekiah' => [
                          'Hez',
                          'Kiah',
                          'Ki',
                          'Ky'
                        ],
          'Orlando' => [
                         'Roland'
                       ],
          'Candace' => [
                         'Candey',
                         'Candi',
                         'Candie',
                         'Candy',
                         'Dacey',
                         'Dacie',
                         'Dacy'
                       ],
          'Franklin' => [
                          'Frank'
                        ],
          'Hiram' => [
                       'Hiley',
                       'Hilie',
                       'Hily'
                     ],
          'Delbert' => [
                         'Bert',
                         'Del',
                         'Dilbert'
                       ],
          'Wallace' => [
                         'Walley',
                         'Wallie',
                         'Wally'
                       ],
          'Edmund' => [
                        'Ed',
                        'Ned',
                        'Ted'
                      ],
          'Yeona' => [
                       'Ona',
                       'Onie'
                     ],
          'Obedience' => [
                           'Beda',
                           'Bede',
                           'Beedey',
                           'Beedie',
                           'Beedy',
                           'Biddie',
                           'Obed'
                         ],
          'Evaline' => [
                         'Eva'
                       ],
          'Zina' => [
                      'Zee'
                    ],
          'Wendy' => [
                       'Wen'
                     ],
          'Naomi' => [
                       'Omi'
                     ],
          'Archibald' => [
                           'Arch',
                           'Archelous',
                           'Archey',
                           'Archie',
                           'Archy',
                           'Baldey',
                           'Baldie',
                           'Baldo',
                           'Baldy'
                         ],
          'Tilford' => [
                         'Tillie'
                       ],
          'Gigliola' => [
                          'Lilly',
                          'Lily'
                        ],
          'Winfield' => [
                          'Field',
                          'Winny',
                          'Win'
                        ],
          'Zelphia' => [
                         'Zella',
                         'Zelphey',
                         'Zelphie',
                         'Zelphy',
                         'Zel'
                       ],
          'Heloise' => [
                         'Eloise',
                         'Lois'
                       ],
          'Gretchen' => [
                          'Margaret'
                        ],
          'Sylvester' => [
                           'Silver',
                           'Silvester',
                           'Si',
                           'Sley',
                           'Slie',
                           'Sly',
                           'Syl',
                           'Sylvanus',
                           'Sy',
                           'Vessey',
                           'Vessie',
                           'Vessy',
                           'Vester',
                           'Vest',
                           'Vet'
                         ],
          'Frederic' => [
                          'Derick',
                          'Eric',
                          'Freddie',
                          'Freddy',
                          'Fred',
                          'Fredric',
                          'Frish',
                          'Fritz'
                        ],
          'Harrison' => [
                          'Harry'
                        ],
          'Elbert' => [
                        'Albert'
                      ],
          'Serena' => [
                        'Rena',
                        'Rina'
                      ],
          'Chester' => [
                         'Chet'
                       ],
          'Posthuma' => [
                          'Humey',
                          'Humie',
                          'Humy'
                        ],
          'Arnold' => [
                        'Arney',
                        'Arnie',
                        'Arny'
                      ],
          'Shaun' => [
                       'Sean',
                       'Shane',
                       'Shawn',
                       'Shayne'
                     ],
          'Madison' => [
                         'Maddy',
                         'Mattie'
                       ],
          'Clarinda' => [
                          'Clara'
                        ],
          'Roberta' => [
                         'Bert',
                         'Birdey',
                         'Birdie',
                         'Birdy',
                         'Bobbie',
                         'Robbie'
                       ],
          'Judith' => [
                        'Juda',
                        'Jude',
                        'Judie',
                        'Judi',
                        'Judy'
                      ],
          'Howard' => [
                        'Hal',
                        'Howey',
                        'Howie',
                        'Howy'
                      ],
          'Hildegarte' => [
                            'Hillie',
                            'Hilly'
                          ],
          'Camille' => [
                         'Cammey',
                         'Cammie',
                         'Cammy',
                         'Millie'
                       ],
          'Andrus' => [
                        'Andy'
                      ],
          'Kimberly' => [
                          'Kimberley',
                          'Kimberlie',
                          'Kimberly',
                          'Kim',
                          'Kimmey',
                          'Kimmie',
                          'Kimmy',
                          'Kymberley',
                          'Kymberlie',
                          'Kymberly',
                          'Kym'
                        ],
          'Eudicy' => [
                        'Dicey'
                      ],
          'Leonidas' => [
                          'Lee',
                          'Leon'
                        ],
          'Megan' => [
                       'Meg'
                     ],
          'Ardeshir' => [
                          'Ardey',
                          'Ardie',
                          'Ardy'
                        ],
          'Temperance' => [
                            'Tempey',
                            'Tempie',
                            'Tempy'
                          ],
          'Timothy' => [
                         'Timmey',
                         'Timmie',
                         'Timmy',
                         'Tim'
                       ],
          'Annie' => [
                       'Hannah',
                       'Nana',
                       'Nan',
                       'Nancy',
                       'Nanny',
                       'Susanna'
                     ],
          'Gustavus' => [
                          'Gus'
                        ],
          'Isaiah' => [
                        'Zadey',
                        'Zadie',
                        'Zady',
                        'Zay'
                      ],
          'Delia' => [
                       'Cordelia',
                       'Fidelia'
                     ],
          'Luann' => [
                       'Louanne',
                       'Louann',
                       'Luanne'
                     ],
          'Dorothea' => [
                          'Doda',
                          'Dora'
                        ],
          'Laveda' => [
                        'Veda'
                      ],
          'Seymour' => [
                         'Morrey',
                         'Morrie',
                         'Morry',
                         'Seymore'
                       ],
          'Jesse' => [
                       'Jess'
                     ],
          'Estella' => [
                         'Essy',
                         'Estelle',
                         'Stella'
                       ],
          'Bradley' => [
                         'Brad'
                       ],
          'Daisy' => [
                       'Margaret'
                     ],
          'Robin' => [
                       'Rob'
                     ],
          'Muriel' => [
                        'Mur'
                      ],
          'Asaph' => [
                       'Asa',
                       'Asahel'
                     ],
          'Anne' => [
                      'Hannah',
                      'Nana',
                      'Nan',
                      'Nancy',
                      'Nanny',
                      'Susanna'
                    ],
          'Iva' => [
                     'Ivy'
                   ],
          'Tipton' => [
                        'Tippey',
                        'Tippie',
                        'Tippy',
                        'Tipsey',
                        'Tipsie',
                        'Tipsy'
                      ],
          'Helena' => [
                        'Aileen',
                        'Eileen',
                        'Elaine',
                        'Eleanor',
                        'Elena',
                        'Ellender',
                        'Ellen',
                        'Helene',
                        'Lena',
                        'Nell',
                        'Nellie'
                      ],
          'Monica' => [
                        'Mona',
                        'Monna',
                        'Monnie'
                      ],
          'Mellony' => [
                         'Mellia'
                       ],
          'Charles' => [
                         'Buck',
                         'Carl',
                         'Chad',
                         'Charley',
                         'Charlie',
                         'Charly',
                         'Chick',
                         'Chuck',
                         'Karel',
                         'Karl'
                       ],
          'Mabel' => [
                       'Amabel',
                       'Mehitabel'
                     ],
          'Jebediah' => [
                          'Jeb'
                        ],
          'Pierre' => [
                        'Pete'
                      ],
          'Charlotte' => [
                           'Car',
                           'Carlotta',
                           'Char',
                           'Charlie',
                           'Letty',
                           'Lotta',
                           'Lottie'
                         ],
          'Hosea' => [
                       'Hosey',
                       'Hosie',
                       'Hosy'
                     ],
          'Kennard' => [
                         'Ken'
                       ],
          'Alice' => [
                       'Alcy',
                       'Aley',
                       'Alicia',
                       'Alie',
                       'Alisha',
                       'Alison',
                       'Allie',
                       'Ally',
                       'Aly',
                       'Elicia',
                       'Elisha',
                       'Ellis',
                       'Elsie',
                       'Lisa',
                       'Lish'
                     ],
          'Roxane' => [
                        'Roxie',
                        'Rox'
                      ],
          'Lionel' => [
                        'Leon'
                      ],
          'Leonore' => [
                         'Elenor',
                         'Honor',
                         'Nora'
                       ],
          'Maurice' => [
                         'Maurey',
                         'Maurie',
                         'Maury',
                         'Moe',
                         'Mo',
                         'Morrie',
                         'Morris',
                         'Morry',
                         'Mossey',
                         'Mossie',
                         'Mossy'
                       ],
          'Kristopher' => [
                            'Chris',
                            'Kris'
                          ],
          'Barnabas' => [
                          'Barnard',
                          'Barney',
                          'Barnie',
                          'Barny',
                          'Bernard',
                          'Berney',
                          'Bernie',
                          'Berny'
                        ],
          'Fredonia' => [
                          'Donia',
                          'Donna'
                        ],
          'Virgil' => [
                        'Virg'
                      ],
          'Lucia' => [
                       'Lucy'
                     ],
          'Melchizedek' => [
                             'Dick',
                             'Zadock'
                           ],
          'Kennett' => [
                         'Ken'
                       ],
          'Otis' => [
                      'Ode',
                      'Ote'
                    ],
          'Sidney' => [
                        'Sid',
                        'Sydney',
                        'Sydnie',
                        'Sydny',
                        'Syd'
                      ],
          'Abraham' => [
                         'Abe',
                         'Abram',
                         'Bram'
                       ],
          'Antonia' => [
                         'Anthony',
                         'Antone',
                         'Nettie'
                       ],
          'Emily' => [
                       'Em',
                       'Emma',
                       'Emmie',
                       'Emmy',
                       'Erma'
                     ],
          'Pleasant' => [
                          'Pleas',
                          'Ples'
                        ],
          'Evelyn' => [
                        'Eve',
                        'Evelina',
                        'Evelyn',
                        'Ev',
                        'Evie'
                      ],
          'Daphne' => [
                        'Daph',
                        'Daphey',
                        'Daphie',
                        'Daphy'
                      ],
          'Content' => [
                         'Tentey',
                         'Tentie',
                         'Tenty'
                       ],
          'Uriah' => [
                       'Ury'
                     ],
          'Jeremy' => [
                        'Jerry'
                      ],
          'Philinda' => [
                          'Phyllis'
                        ],
          'Pandora' => [
                         'Dora'
                       ],
          'Smith' => [
                       'Smittey',
                       'Smittie',
                       'Smitty'
                     ],
          'Elbertson' => [
                           'Bert',
                           'Elbert'
                         ],
          'Violetta' => [
                          'Lettie'
                        ],
          'Vanburen' => [
                          'Buren'
                        ],
          'Eudora' => [
                        'Dora'
                      ],
          'Genevieve' => [
                           'Gencey',
                           'Gencie',
                           'Gency',
                           'Genny',
                           'Jenna',
                           'Jenny',
                           'Jinsey',
                           'Neva'
                         ],
          'Odell' => [
                       'Odo'
                     ],
          'Francis' => [
                         'Frank',
                         'Frankisek',
                         'Franklin',
                         'Franz'
                       ],
          'Adelaide' => [
                          'Ada',
                          'Adaline',
                          'Addie',
                          'Adela',
                          'Adelia',
                          'Adeline',
                          'Adeliza',
                          'Della',
                          'Heide',
                          'Heidey',
                          'Heidie',
                          'Heidy'
                        ],
          'Darwin' => [
                        'Darey',
                        'Darie',
                        'Dary'
                      ],
          'Ellie' => [
                       'Eleanor',
                       'Gabriella',
                       'Helen',
                       'Luella'
                     ],
          'Hepsabah' => [
                          'Hebsabeth',
                          'Hephsibah',
                          'Hepsabel',
                          'Hepsey',
                          'Hepsibah',
                          'Hepsie',
                          'Hepsy'
                        ],
          'Cole' => [
                      'Colie'
                    ],
          'Alonzo' => [
                        'Al',
                        'Alphonzo',
                        'Lon',
                        'Lonnie',
                        'Lonzo'
                      ],
          'Evangeline' => [
                            'Evan',
                            'Ev',
                            'Vangey',
                            'Vangie',
                            'Vangy'
                          ],
          'Hortense' => [
                          'Harty',
                          'Tensey',
                          'Tensie',
                          'Tensy'
                        ],
          'May' => [
                     'Mae'
                   ],
          'Hester' => [
                        'Esther',
                        'Hessey',
                        'Hessie',
                        'Hessy',
                        'Hetty'
                      ],
          'Iona' => [
                      'Onney',
                      'Onnie',
                      'Onny'
                    ],
          'Rufina' => [
                        'Fina',
                        'Refina'
                      ],
          'Alyssa' => [
                        'Al',
                        'Ally',
                        'Lissia'
                      ],
          'Sigismund' => [
                           'Sigmund',
                           'Sig'
                         ],
          'Ian' => [
                     'John'
                   ],
          'Alazama' => [
                         'Ali'
                       ],
          'Cecilia' => [
                         'Cece',
                         'Ceceley',
                         'Cecelie',
                         'Cecely',
                         'Cecil',
                         'Ceciley',
                         'Cecilie',
                         'Cecily',
                         'Celia',
                         'Cissy',
                         'Sissy'
                       ],
          'Raphael' => [
                         'Raff',
                         'Ralph'
                       ],
          'Honora' => [
                        'Honey',
                        'Honie',
                        'Hony',
                        'Norah',
                        'Nora',
                        'Norrey',
                        'Norrie',
                        'Norry'
                      ],
          'Michael' => [
                         'Micah',
                         'Mickey',
                         'Mickie',
                         'Mick',
                         'Micky',
                         'Mike',
                         'Mitchell'
                       ],
          'Appoline' => [
                          'Appey',
                          'Appie',
                          'Appy'
                        ],
          'Sigfired' => [
                          'Sid'
                        ],
          'Janice' => [
                        'Jan'
                      ],
          'Sarah' => [
                       'Cera',
                       'Sadey',
                       'Sadie',
                       'Sady',
                       'Salley',
                       'Sallie',
                       'Sally',
                       'Sal',
                       'Sarai',
                       'Sara',
                       'Sukie',
                       'Surrey',
                       'Surrie',
                       'Surry'
                     ],
          'Arminta' => [
                         'Minite',
                         'Minnie'
                       ],
          'Nelson' => [
                        'Nels'
                      ],
          'Beatrix' => [
                         'Bea'
                       ],
          'Adam' => [
                      'Ade',
                      'Edie'
                    ],
          'Manerva' => [
                         'Eve',
                         'Minerva',
                         'Nerva',
                         'Nervie'
                       ],
          'Sarilla' => [
                         'Silla'
                       ],
          'Luciana' => [
                         'Lucia'
                       ],
          'Adaline' => [
                         'Ada',
                         'Adela',
                         'Aline',
                         'Edith'
                       ],
          'Bengta' => [
                        'Ben'
                      ],
          'Jennifer' => [
                          'Jan',
                          'Jen',
                          'Jenna',
                          'Jenny',
                          'Winifred'
                        ],
          'Tasha' => [
                       'Tashey',
                       'Tashie',
                       'Tash',
                       'Tashy'
                     ],
          'Cathleen' => [
                          'Cathy',
                          'Karen',
                          'Katharine',
                          'Katie'
                        ],
          'Nicolena' => [
                          'Nicolene',
                          'Nicole',
                          'Nicolina',
                          'Nikkey',
                          'Nikkie',
                          'Nikky'
                        ],
          'Euphemia' => [
                          'Effey',
                          'Effie',
                          'Effy'
                        ],
          'Georgia' => [
                         'Georgiana'
                       ],
          'Suzanne' => [
                         'Sue',
                         'Suki',
                         'Suzie',
                         'Suzi',
                         'Suzy'
                       ],
          'Mitchell' => [
                          'Michael',
                          'Mitch'
                        ],
          'Gilbert' => [
                         'Bert',
                         'Bertie',
                         'Gib',
                         'Gil',
                         'Gill',
                         'Wilber'
                       ],
          'Wycliffe' => [
                          'Cliff'
                        ],
          'Bertha' => [
                        'Bertie'
                      ],
          'Angelina' => [
                          'Lina'
                        ],
          'Stuart' => [
                        'Stu'
                      ],
          'Bradford' => [
                          'Brad',
                          'Bradley',
                          'Bradlie',
                          'Bradly'
                        ],
          'Manfred' => [
                         'Freddie',
                         'Freddy',
                         'Fred',
                         'Manny'
                       ],
          'Sullivan' => [
                          'Sulley',
                          'Sullie',
                          'Sully'
                        ]
);
%nicknames = (
          'Bram' => 'Abraham',
          'Dicy' => 'Laodicia',
          'Beth' => 'Elizabeth',
          'Monnie' => 'Monica',
          'Loren' => 'Lorenzo',
          'Delf' => 'Delphine',
          'Cecil' => 'Cecilia',
          'Teresa' => 'Theresa',
          'Ciller' => 'Priscilla',
          'Pat' => 'Patrick',
          'Phililpa' => 'Philipina',
          'Biah' => 'Abijah',
          'Dell' => 'Delilah',
          'Nabbie' => 'Abigail',
          'Linda' => 'Melinda',
          'Trina' => 'Katrina',
          'Nibbey' => 'Isabella',
          'Nada' => 'Nadine',
          'Ronna' => 'Veronica',
          'Darrie' => 'Darlene',
          'Mack' => 'Mackenzie',
          'Jenny' => 'Virginia',
          'Deedee' => 'Deidre',
          'Bab' => 'Barbara',
          'Scottie' => 'Prescott',
          'Margerey' => 'Margaret',
          'Barbara' => 'Barbery',
          'Kenney' => 'Kenneth',
          'Nolley' => 'Olivia',
          'Helene' => 'Helena',
          'Tenny' => 'Tennessee',
          'Bonnie' => 'Bonita',
          'Wilber' => 'Gilbert',
          'Ophey' => 'Theophilus',
          'Abie' => 'Abigail',
          'Jameson' => 'James',
          'Dahl' => 'Dalton',
          'Tavia' => 'Octavia',
          'Ponie' => 'Napoleon',
          'Renny' => 'Warren',
          'Ted' => 'Theodore',
          'Maddey' => 'Madeline',
          'Mellia' => 'Mellony',
          'Gatsbey' => 'Augustus',
          'Max' => 'Maxwell',
          'Peney' => 'Philipina',
          'Hilie' => 'Hiram',
          'Tempie' => 'Temperance',
          'Elaina' => 'Elaine',
          'Desey' => 'Desiree',
          'Tipsy' => 'Tipton',
          'Rye' => 'Zachariah',
          'Eloise' => 'Lousie',
          'Tammi' => 'Tamara',
          'Leet' => 'Philetus',
          'Jorge' => 'George',
          'Aphinius' => 'Alphinias',
          'One' => 'Onicyphorous',
          'Gerey' => 'Geraldine',
          'Waldo' => 'Oswald',
          'France' => 'Frances',
          'Lucinda' => 'Cynthia',
          'Bry' => 'Bridget',
          'Adrian' => 'Adrienne',
          'Izzy' => 'Isidore',
          'Malc' => 'Malcolm',
          'Mena' => 'Philomena',
          'Kery' => 'Caroline',
          'Hosie' => 'Hosea',
          'Mec' => 'America',
          'Lexi' => 'Alexis',
          'Nessie' => 'Agnes',
          'Becka' => 'Rebecca',
          'Ander' => 'Anderson',
          'Jean' => 'John',
          'Sibbey' => 'Sibbilla',
          'Jenna' => 'Jennifer',
          'Angel' => 'Angela',
          'Joey' => 'Josephine',
          'Cathy' => 'Kathryn',
          'Si' => 'Sylvester',
          'Emanuel' => 'Manuel',
          'Margaret' => 'Gretchen',
          'Emma' => 'Emily',
          'Lanna' => 'Eleanor',
          'Rudolph' => 'Rudolphus',
          'Phelia' => 'Orphelia',
          'Kenjey' => 'Kendra',
          'Gee' => 'Jehu',
          'Elaine' => 'Helena',
          'Margery' => 'Margaret',
          'Hez' => 'Hezekiah',
          'Lan' => 'Yulan',
          'Appie' => 'Appoline',
          'Lonnie' => 'Lawrence',
          'Alfy' => 'Alfreda',
          'Virgy' => 'Virginia',
          'Net' => 'Antoinette',
          'Delilah' => 'Della',
          'Dede' => 'Deirdre',
          'Kit' => 'Kathryn',
          'Trudey' => 'Gertrude',
          'Tenney' => 'Tennessee',
          'Bradie' => 'Broderick',
          'Kenna' => 'Mckenna',
          'Hassie' => 'Haseltine',
          'Alfred' => 'Alfreda',
          'Gertie' => 'Gertrude',
          'Netta' => 'Antoinette',
          'Renius' => 'Cyrenius',
          'Finnius' => 'Alphinias',
          'Dobbin' => 'Robert',
          'Lodie' => 'Melody',
          'Vinie' => 'Lavinia',
          'Kittey' => 'Katherine',
          'Shelly' => 'Sheldon',
          'Kay-kay' => 'Kayla',
          'Christina' => 'Christiana',
          'Edna' => 'Edith',
          'Anthony' => 'Antonia',
          'Desree' => 'Desiree',
          'Densie' => 'Prudence',
          'Lloyd' => 'Floyd',
          'Elinamifia' => 'Eleanor',
          'Shayne' => 'Shaun',
          'Arilla' => 'Cinderella',
          'Burt' => 'Herbert',
          'Naz' => 'Ignatzio',
          'Meta' => 'Margaret',
          'Clara' => 'Clarissa',
          'Orolia' => 'Caroline',
          'Wes' => 'Weston',
          'Dona' => 'Caldonia',
          'Krissie' => 'Kristine',
          'Trannie' => 'Tranquilla',
          'Effie' => 'Euphemia',
          'Kim' => 'Kimberly',
          'Jerri' => 'Marjory',
          'Georgiana' => 'Georgia',
          'Alicia' => 'Alice',
          'Jayce' => 'Jane',
          'Bear' => 'Barry',
          'Arch' => 'Archibald',
          'Pony' => 'Napoleon',
          'Dorinda' => 'Dorothy',
          'Kasey' => 'Casey',
          'Rudi' => 'Rudolph',
          'Cindi' => 'Lucinda',
          'Cordey' => 'Cordelia',
          'Marci' => 'Marsha',
          'Arlie' => 'Arlene',
          'Philly' => 'Adelphia',
          'Maverey' => 'Mavine',
          'Nana' => 'Annie',
          'Phip' => 'Phillip',
          'Denny' => 'Dennis',
          'Gery' => 'Geraldine',
          'Kendall' => 'Kenneth',
          'Jeremey' => 'Jeremiah',
          'Roddey' => 'Rodney',
          'Elenor' => 'Leonore',
          'Dicey' => 'Eurydice',
          'Jackie' => 'Jacqueline',
          'Baisy' => 'Elizabeth',
          'Sabe' => 'Isabellea',
          'Morry' => 'Seymour',
          'Dennison' => 'Dennis',
          'Cornie' => 'Cornelia',
          'Baldie' => 'Archibald',
          'Jude' => 'Judith',
          'Carlotta' => 'Charlotte',
          'Mamy' => 'Mary',
          'Ferby' => 'Pharaba',
          'Tyrza' => 'Teresa',
          'Eileen' => 'Helena',
          'Roddie' => 'Rodney',
          'Vinny' => 'Vincent',
          'Dotty' => 'Dorothy',
          'Barnard' => 'Barnabas',
          'Norah' => 'Honora',
          'Inez' => 'Agnes',
          'Leonora' => 'Eleanor',
          'Janett' => 'Jane',
          'Clarissa' => 'Clara',
          'Ferdy' => 'Ferdinand',
          'Onney' => 'Iona',
          'Leffie' => 'Lafayette',
          'Bradly' => 'Bradford',
          'Tonie' => 'Antoinette',
          'Betsie' => 'Elizabeth',
          'Vin' => 'Vincent',
          'Crece' => 'Lucretia',
          'Kathleen' => 'Katherine',
          'Hermey' => 'Hermione',
          'Emmanuel' => 'Immanuel',
          'Janiece' => 'Jane',
          'Jamie' => 'James',
          'Arey' => 'Arielle',
          'Sam' => 'Samuel',
          'Mira' => 'Miranda',
          'Dolph' => 'Rudolph',
          'Trixie' => 'Patricia',
          'Barberie' => 'Barbara',
          'Prudie' => 'Prudence',
          'Athy' => 'Eighta',
          'Winny' => 'Winifred',
          'Huldah' => 'Mahala',
          'Provy' => 'Providence',
          'Kingsly' => 'King',
          'Hittie' => 'Mehitabel',
          'Gencie' => 'Genevieve',
          'Jon' => 'Jonathan',
          'Biel' => 'Abiel',
          'Lotta' => 'Charlotte',
          'Rickie' => 'Roderick',
          'Ferbey' => 'Pharaba',
          'Jaime' => 'James',
          'Dottie' => 'Dorothy',
          'Gustie' => 'Augustus',
          'Myrty' => 'Myrtle',
          'Dew' => 'Andrew',
          'Hans' => 'John',
          'Matt' => 'Matthias',
          'Retta' => 'Loretta',
          'Marty' => 'Martin',
          'Mamie' => 'Mary',
          'Carl' => 'Charles',
          'Candey' => 'Candace',
          'Gay' => 'Gerhardt',
          'Brodey' => 'Broderick',
          'Lavina' => 'Lavinia',
          'Becky' => 'Rebecca',
          'Erny' => 'Earnest',
          'Scotty' => 'Prescott',
          'Lorne' => 'Lawrence',
          'Aileen' => 'Helena',
          'Tave' => 'Octavia',
          'Marjory' => 'Margaret',
          'Herb' => 'Herbert',
          'Hermoine' => 'Hermione',
          'Dal' => 'Dalton',
          'Ozzy' => 'Oswald',
          'Charm' => 'Carmon',
          'Delpha' => 'Philadelphia',
          'Rella' => 'Cinderella',
          'Nina' => 'Enedina',
          'Hitty' => 'Mehitabel',
          'Baldy' => 'Archibald',
          'Sibyl' => 'Sibbilla',
          'Happie' => 'Karonhappuck',
          'Little' => 'Littleberry',
          'Angelica' => 'Angela',
          'Lineau' => 'Leonard',
          'Gus' => 'Gustavus',
          'Bart' => 'Barticus',
          'Lyddie' => 'Linda',
          'Syphorous' => 'Onicyphorous',
          'Pru' => 'Prudence',
          'Laurence' => 'Lawrence',
          'Ferbie' => 'Pheriba',
          'Stevie' => 'Stephen',
          'Denys' => 'Denise',
          'Sheron' => 'Sharon',
          'Tiah' => 'Azariah',
          'Mari' => 'Miranda',
          'Sue' => 'Suzanne',
          'Felicia' => 'Felicity',
          'Alan' => 'Alanson',
          'Gil' => 'Guilford',
          'Finney' => 'Phineas',
          'Maurey' => 'Maurice',
          'Peggie' => 'Margarita',
          'Jany' => 'Jane',
          'Suzie' => 'Suzanne',
          'Barb' => 'Barbara',
          'Lody' => 'Melody',
          'Kristy' => 'Christiana',
          'Sica' => 'Jessica',
          'Danelle' => 'Danielle',
          'Ronnie' => 'Veronica',
          'Lainy' => 'Elaine',
          'Pris' => 'Priscilla',
          'Beedey' => 'Obedience',
          'Vet' => 'Sylvester',
          'Trudie' => 'Gertrude',
          'Middy' => 'Madeline',
          'Basil' => 'Bazaleel',
          'Cenia' => 'Laodicia',
          'Alexandra' => 'Sandra',
          'Silvester' => 'Sylvester',
          'Reba' => 'Rebecca',
          'Alphonzo' => 'Alonzo',
          'Valery' => 'Valentina',
          'Flo' => 'Florence',
          'Zolley' => 'Solomon',
          'Gerrie' => 'Geraldine',
          'Les' => 'Lester',
          'Timmey' => 'Timothy',
          'Gatsbie' => 'Augustus',
          'Field' => 'Winfield',
          'Vannie' => 'Vanessa',
          'Ginny' => 'Virginia',
          'Chan' => 'Chauncy',
          'Diane' => 'Diana',
          'Geoff' => 'Jefferson',
          'Vert' => 'Alverta',
          'Jake' => 'Jacob',
          'Juney' => 'Junior',
          'Laurey' => 'Lauryn',
          'Lula' => 'Luella',
          'Shawn' => 'Shaun',
          'Quil' => 'Aquilla',
          'Nessa' => 'Vanessa',
          'Andrew' => 'Andrea',
          'Jody' => 'Joanna',
          'Sandi' => 'Cassandra',
          'Karey' => 'Caroline',
          'Barbarie' => 'Barbara',
          'Roseann' => 'Roseanne',
          'Bitsy' => 'Elizabeth',
          'Margie' => 'Marjorie',
          'Nerva' => 'Minerva',
          'Minite' => 'Arminta',
          'Dodie' => 'Delores',
          'Penney' => 'Penelope',
          'Smittey' => 'Smith',
          'Natty' => 'Nathaniel',
          'Baisey' => 'Elizabeth',
          'Rodger' => 'Roger',
          'Antoine' => 'Anthony',
          'Debi' => 'Deborah',
          'Volodia' => 'Vladimir',
          'Ab' => 'Absalom',
          'Augie' => 'Augustina',
          'Sigmund' => 'Sigismund',
          'Drea' => 'Andrea',
          'Tina' => 'Kristina',
          'Ben' => 'Benton',
          'Barbie' => 'Barbara',
          'Margo' => 'Margarita',
          'Dot' => 'Dorothy',
          'Genie' => 'Eugenia',
          'Pleas' => 'Pleasant',
          'Nickie' => 'Nicole',
          'Frieda' => 'Alfreda',
          'Rian' => 'Brian',
          'Louvinia' => 'Lavinia',
          'Horry' => 'Horace',
          'Stevy' => 'Stephen',
          'Elsie' => 'Elizabeth',
          'Kathe' => 'Katherine',
          'Bryan' => 'Brian',
          'Tibbie' => 'Isabellea',
          'Kingslie' => 'King',
          'Art' => 'Arthur',
          'Teddy' => 'Theodore',
          'Jemma' => 'Jemima',
          'Jaap' => 'Jacob',
          'Jim' => 'James',
          'Erwin' => 'Irwin',
          'Barbarey' => 'Barbara',
          'Zeph' => 'Zepaniah',
          'Sulley' => 'Sullivan',
          'Flora' => 'Florence',
          'Maureen' => 'Mary',
          'Wilhelm' => 'William',
          'Madeleine' => 'Madeline',
          'Arly' => 'Arlene',
          'Clare' => 'Clarissa',
          'Tiffy' => 'Tiffany',
          'Arnie' => 'Arnold',
          'Donney' => 'Donald',
          'Jacque' => 'Jacqueline',
          'Addie' => 'Adelaide',
          'Kimmie' => 'Kimberly',
          'Quinn' => 'Quince',
          'Augustine' => 'Augustus',
          'Theodora' => 'Theodosia',
          'Ricky' => 'Eric',
          'Benjy' => 'Benjamin',
          'Surrie' => 'Sarah',
          'Gatsby' => 'Augustus',
          'Ora' => 'Orilla',
          'Jennie' => 'Virginia',
          'Nathey' => 'Asenath',
          'Dock' => 'Zadock',
          'Bige' => 'Abijah',
          'Ade' => 'Adam',
          'Buck' => 'Charles',
          'Niel' => 'Cornelius',
          'Frish' => 'Frederik',
          'Maria' => 'Mary',
          'Fan' => 'Frances',
          'Helen' => 'Ellie',
          'Phoenie' => 'Tryphena',
          'Edie' => 'Edith',
          'Suzi' => 'Suzanne',
          'Fredric' => 'Frederik',
          'Ced' => 'Cedrick',
          'Kurtis' => 'Curtis',
          'Mose' => 'Moses',
          'Ance' => 'Anselm',
          'Millie' => 'Emeline',
          'Hiley' => 'Hiram',
          'Immanuel' => 'Emanuel',
          'Darrey' => 'Darlene',
          'Telley' => 'Aristotle',
          'Donny' => 'Donald',
          'Caddie' => 'Carolyn',
          'Marge' => 'Marjory',
          'Lessie' => 'Celeste',
          'Nicie' => 'Vernisee',
          'Wilma' => 'Wilhelmina',
          'Betty' => 'Elizabeth',
          'Lenny' => 'Leonard',
          'Brodie' => 'Broderick',
          'Rusty' => 'Russell',
          'Cammey' => 'Camille',
          'Cristina' => 'Christiana',
          'Ples' => 'Pleasant',
          'Wily' => 'William',
          'Hepsabel' => 'Hepsabah',
          'Del' => 'Delphine',
          'Rafe' => 'Randolph',
          'Johannah' => 'Joanna',
          'Percey' => 'Percival',
          'Bela' => 'William',
          'Dewayne' => 'Duane',
          'Nikki' => 'Nicole',
          'Horrey' => 'Horace',
          'Dottey' => 'Dorothy',
          'Lorinda' => 'Laurinda',
          'Sallie' => 'Sarah',
          'Emmer' => 'Emeline',
          'Janette' => 'Jane',
          'Joe' => 'Joseph',
          'Zubiah' => 'Azubah',
          'Beckey' => 'Rebecca',
          'Delphi' => 'Delphine',
          'Steph' => 'Stephen',
          'Kizza' => 'Keziah',
          'Govie' => 'Governor',
          'Josh' => 'Joshua',
          'Cissy' => 'Clarissa',
          'Electa' => 'Electra',
          'Diah' => 'Obadiah',
          'Pete' => 'Pierre',
          'Lindy' => 'Melinda',
          'Tabbie' => 'Tabitha',
          'Em' => 'Emily',
          'Vergie' => 'Virginia',
          'Julian' => 'Julias',
          'Rolf' => 'Rudolphus',
          'Heide' => 'Adelaide',
          'Kary' => 'Caroline',
          'Ceciley' => 'Cecilia',
          'Prissy' => 'Priscilla',
          'Juliet' => 'Julia',
          'Becca' => 'Rebecca',
          'Torry' => 'Victoria',
          'Penie' => 'Philipina',
          'Orlando' => 'Roland',
          'Franklin' => 'Francis',
          'Obe' => 'Obadiah',
          'Morrey' => 'Seymour',
          'Lig' => 'Elijah',
          'Corky' => 'Courtney',
          'Sabra' => 'Sabrina',
          'Nappey' => 'Napoleon',
          'Zeke' => 'Zachariah',
          'Magdalen' => 'Magdelina',
          'Kymberley' => 'Kimberly',
          'Frankie' => 'Frances',
          'Lawrey' => 'Lawrence',
          'Honey' => 'Honora',
          'Heloise' => 'Lois',
          'Etty' => 'Carthaette',
          'Torey' => 'Victoria',
          'Grissel' => 'Griselda',
          'Merv' => 'Marvin',
          'Elbert' => 'Elbertson',
          'Desirey' => 'Desiree',
          'Serena' => 'Sabrina',
          'Nervie' => 'Minerva',
          'Sibella' => 'Isabellea',
          'Lyddey' => 'Linda',
          'Zaddy' => 'Arzada',
          'Clarinda' => 'Clarissa',
          'Johanna' => 'Joanna',
          'Lanson' => 'Alanson',
          'Bonny' => 'Bonita',
          'Anny' => 'Savannah',
          'Dorothea' => 'Dorothy',
          'Will' => 'William',
          'Jesse' => 'Jessica',
          'Benjey' => 'Benjamin',
          'Ivy' => 'Iva',
          'Daisy' => 'Marguerite',
          'Perry' => 'Pelegrine',
          'Algy' => 'Algernon',
          'Beck' => 'Rebecca',
          'Robin' => 'Robert',
          'Hally' => 'Mahalla',
          'Daney' => 'Danielle',
          'Salmon' => 'Solomon',
          'Sebby' => 'Sebastian',
          'Reggi' => 'Reginald',
          'Jr' => 'Junior',
          'Allie' => 'Almena',
          'Stacia' => 'Eustacia',
          'Curt' => 'Curtis',
          'Vicie' => 'Lewvisa',
          'Scott' => 'Prescott',
          'Hilly' => 'Hillary',
          'Melchizedek' => 'Zadock',
          'Green' => 'Greenberry',
          'Jeffrie' => 'Jefferson',
          'Falley' => 'Eliphalet',
          'Barnie' => 'Bernard',
          'Sully' => 'Sullivan',
          'Antonia' => 'Antoinette',
          'Emily' => 'Emeline',
          'Greg' => 'Gregory',
          'Vicki' => 'Victoria',
          'Evelyn' => 'Evelyn',
          'Ellis' => 'Elisha',
          'Aggie' => 'Agatha',
          'Ferdie' => 'Ferdinando',
          'Cass' => 'Caswell',
          'Mehetabel' => 'Mehitabel',
          'Tony' => 'Antony',
          'Dani' => 'Danielle',
          'Pres' => 'Prescott',
          'Parsuney' => 'Parthenia',
          'Susanna' => 'Annie',
          'Fran' => 'Francine',
          'Dosia' => 'Theodosia',
          'Adelaide' => 'Della',
          'Luci' => 'Lucinda',
          'Mat' => 'Matthias',
          'Neely' => 'Cornelius',
          'Zay' => 'Isaiah',
          'Terrie' => 'Therese',
          'Left' => 'Lafayette',
          'Cecilia' => 'Sheila',
          'Kent' => 'Kenneth',
          'Vanna' => 'Vanessa',
          'Rilla' => 'Serilla',
          'Theodorick' => 'Theodore',
          'Hamp' => 'Hamilton',
          'Billey' => 'William',
          'Kitsey' => 'Katherine',
          'Dimmis' => 'Demerias',
          'Stella' => 'Estella',
          'Woody' => 'Woodrow',
          'Zadock' => 'Melchizedek',
          'Stephie' => 'Stephanie',
          'Janet' => 'Jessie',
          'Roddy' => 'Rodney',
          'Sophia' => 'Sophronia',
          'Montesque' => 'Montgomery',
          'Lucy' => 'Lucinda',
          'Hillie' => 'Hillary',
          'Sephy' => 'Persephone',
          'Kezzie' => 'Keziah',
          'Ozzie' => 'Oswald',
          'Alcy' => 'Alice',
          'Fannie' => 'Frances',
          'Lannie' => 'Roland',
          'Erney' => 'Earnest',
          'Crissey' => 'Christiana',
          'Indey' => 'India',
          'Karie' => 'Caroline',
          'Gusy' => 'Augusta',
          'Carole' => 'Caroline',
          'Essie' => 'Esther',
          'Daphie' => 'Daphne',
          'Hetty' => 'Mehitabel',
          'Lanney' => 'Roland',
          'Rolly' => 'Roland',
          'Elic' => 'Alexandria',
          'Cammie' => 'Carmon',
          'Veda' => 'Laveda',
          'Erin' => 'Aaron',
          'Missa' => 'Melissa',
          'Melly' => 'Permelia',
          'Osaforus' => 'Onicyphorous',
          'Cono' => 'Cornelius',
          'Mia' => 'Marianna',
          'Rennie' => 'Warren',
          'Lilie' => 'Lillian',
          'Refina' => 'Rufina',
          'Debora' => 'Deborah',
          'Julie' => 'Julia',
          'Bev' => 'Beverly',
          'Rosable' => 'Rosabella',
          'Laffie' => 'Lafayette',
          'Tashy' => 'Tasha',
          'Densey' => 'Prudence',
          'Samson' => 'Sampson',
          'Win' => 'Winthrop',
          'Marie' => 'Mary',
          'Lainie' => 'Elaine',
          'Davie' => 'David',
          'Fronia' => 'Sophronia',
          'Lillah' => 'Lillian',
          'Wendie' => 'Gwendolyn',
          'Vinnie' => 'Vincent',
          'Lias' => 'Elias',
          'Mimi' => 'Mildred',
          'Sandie' => 'Alexandra',
          'Tempy' => 'Temperance',
          'Lynette' => 'Linda',
          'Dora' => 'Theodora',
          'Jimmey' => 'James',
          'Sheryl' => 'Sharon',
          'Daisey' => 'Margaret',
          'Wiley' => 'William',
          'Pauline' => 'Paulina',
          'Kate' => 'Kathyn',
          'Jerry' => 'Marjory',
          'Norrey' => 'Honora',
          'Ana' => 'Anastasia',
          'Ike' => 'Isaac',
          'Mercy' => 'Mercedes',
          'Hub' => 'Hubert',
          'Glorie' => 'Gloria',
          'Marv' => 'Marvin',
          'Dickson' => 'Richard',
          'Issy' => 'Isadora',
          'Lexa' => 'Alexandria',
          'Kurt' => 'Curtis',
          'Chat' => 'Charity',
          'Tipsey' => 'Tipton',
          'Shel' => 'Sheldon',
          'Beedie' => 'Obedience',
          'Toria' => 'Victoria',
          'Hatty' => 'Henrietta',
          'Katharine' => 'Kathleen',
          'Junie' => 'Junior',
          'Kerey' => 'Caroline',
          'Sol' => 'Solomon',
          'Lilly' => 'Lillian',
          'Tammie' => 'Tamara',
          'Sim' => 'Simeon',
          'Susy' => 'Susannah',
          'Pheobe' => 'Tryphena',
          'Metta' => 'Margarita',
          'Kennie' => 'Kenneth',
          'Greta' => 'Margarita',
          'Cassy' => 'Cassandra',
          'Maryanna' => 'Maryanne',
          'Livey' => 'Olivia',
          'Laura' => 'Lorinda',
          'Roxie' => 'Roxane',
          'Reynold' => 'Reginald',
          'Brie' => 'Bridget',
          'Crissy' => 'Kristine',
          'Tashey' => 'Tasha',
          'Livia' => 'Olivia',
          'Hephsibah' => 'Hepsabah',
          'Joanne' => 'Joanna',
          'Virdie' => 'Alverta',
          'Azarich' => 'Azariah',
          'Kissie' => 'Calista',
          'Ernest' => 'Earnest',
          'Dolf' => 'Rudolphus',
          'Ednie' => 'Edith',
          'Tibbey' => 'Isabella',
          'Judy' => 'Judith',
          'Bennett' => 'Benedict',
          'Norrie' => 'Honora',
          'Yolonda' => 'Yolanda',
          'Noah' => 'Manoah',
          'Jacobus' => 'Jacob',
          'Fitzie' => 'Fitzgerald',
          'Philley' => 'Adelphia',
          'Gregg' => 'Gregory',
          'Merle' => 'Merlin',
          'Roxy' => 'Roseanne',
          'Onie' => 'Yeona',
          'Lidia' => 'Linda',
          'Tabby' => 'Tabitha',
          'Obie' => 'Obadiah',
          'Callie' => 'California',
          'Susannah' => 'Hannah',
          'Nettie' => 'Pernetta',
          'Cecily' => 'Cecilia',
          'Mickey' => 'Michelle',
          'Juley' => 'Julia',
          'Brina' => 'Sabrina',
          'Phoeney' => 'Tryphena',
          'Lessy' => 'Celeste',
          'Sylvanus' => 'Sylvester',
          'Carrie' => 'Karonhappuck',
          'Larrey' => 'Lawrence',
          'Rosabella' => 'Isabella',
          'Bridgit' => 'Bedelia',
          'Rollie' => 'Roland',
          'July' => 'Julia',
          'Fay' => 'Faith',
          'Celina' => 'Selina',
          'Sid' => 'Sydney',
          'Sibbie' => 'Sybill',
          'Hattey' => 'Harriet',
          'Nate' => 'Nathaniel',
          'Davey' => 'David',
          'Peg' => 'Margaret',
          'Augusta' => 'Augustus',
          'Cil' => 'Priscilla',
          'Mitzi' => 'Miriam',
          'Lizzy' => 'Elizabeth',
          'Tiff' => 'Tiffany',
          'Phoebe' => 'Philipina',
          'Cora' => 'Corinne',
          'Mollie' => 'Mary',
          'Arabelle' => 'Arabella',
          'Ceceley' => 'Cecilia',
          'Theney' => 'Parthenia',
          'Zacharias' => 'Zachariah',
          'Ella' => 'Luella',
          'Stu' => 'Stuart',
          'Peddy' => 'Experience',
          'Odo' => 'Odell',
          'Jeffrey' => 'Jefferson',
          'Wilbur' => 'Wilber',
          'Phineas' => 'Alphinias',
          'Roxanne' => 'Roseanne',
          'Eph' => 'Ephraim',
          'Beverlie' => 'Beverly',
          'Tippie' => 'Tipton',
          'Angy' => 'Angela',
          'Abbie' => 'Absalom',
          'Rollo' => 'Rudolph',
          'Marnie' => 'Martha',
          'Julius' => 'Julias',
          'Debby' => 'Deborah',
          'Phosy' => 'Tryphosia',
          'Myra' => 'Almira',
          'Cally' => 'Calpurnia',
          'Cris' => 'Christiana',
          'Ann' => 'Nancy',
          'Fayette' => 'Lafayette',
          'Wenefred' => 'Winifred',
          'Sadie' => 'Sarah',
          'Torrie' => 'Victoria',
          'Surrey' => 'Sarah',
          'Katey' => 'Katherine',
          'Lonson' => 'Alanson',
          'Tamzine' => 'Thomasine',
          'Lil' => 'Lillian',
          'Jakie' => 'Jacqueline',
          'Talley' => 'Natalie',
          'Doris' => 'Dorothy',
          'Rhodey' => 'Rhodella',
          'Fitzy' => 'Fitzgerald',
          'Kitsy' => 'Katherine',
          'Neppy' => 'Penelope',
          'Feli' => 'Felicia',
          'Aly' => 'Alice',
          'Cleat' => 'Cleatus',
          'Horatio' => 'Horace',
          'Crese' => 'Lucretia',
          'Noel' => 'Nowell',
          'Desry' => 'Desiree',
          'Cibyl' => 'Sibbilla',
          'Thias' => 'Matthew',
          'Ritchie' => 'Richard',
          'Dotha' => 'Dorothy',
          'Rhynie' => 'Rhyna',
          'Con' => 'Conrad',
          'Kenj' => 'Kendra',
          'Nelly' => 'Eleanor',
          'Madge' => 'Marjorie',
          'Kizzy' => 'Keziah',
          'Cammy' => 'Camille',
          'Therese' => 'Theresa',
          'Baissey' => 'Elizabeth',
          'Court' => 'Courtney',
          'Neva' => 'Genevieve',
          'Cal' => 'Calvin',
          'Tentey' => 'Content',
          'Frankisek' => 'Francis',
          'Timmie' => 'Timothy',
          'Perce' => 'Percival',
          'Sion' => 'Simeon',
          'Manuel' => 'Immanuel',
          'Brandy' => 'Brenda',
          'Francie' => 'Francine',
          'Hallie' => 'Mahalla',
          'Sophey' => 'Sophronia',
          'Mehitable' => 'Mehitabel',
          'Sukey' => 'Susannah',
          'Thirsa' => 'Theresa',
          'Elis' => 'Elizabeth',
          'Geoffry' => 'Jefferson',
          'Gerri' => 'Geraldine',
          'Nelle' => 'Cornelia',
          'Omi' => 'Naomi',
          'Ditus' => 'Aphrodite',
          'Kendrick' => 'Kenneth',
          'Mort' => 'Morton',
          'Indie' => 'India',
          'Wib' => 'Wilber',
          'Liz' => 'Elizabeth',
          'Gussie' => 'Augustina',
          'Dosie' => 'Eudoris',
          'Gabbie' => 'Gabrielle',
          'Randall' => 'Randolph',
          'Myrtey' => 'Myrtle',
          'Zolly' => 'Solomon',
          'Kenzy' => 'Mackenzie',
          'Desiry' => 'Desiree',
          'Rudie' => 'Rudolphus',
          'Aley' => 'Alice',
          'Mona' => 'Ramona',
          'Elizabeth' => 'Melissa',
          'Fannney' => 'Nathaniel',
          'Nattie' => 'Natalie',
          'Sollie' => 'Solomon',
          'Harrie' => 'Harriet',
          'Tilly' => 'Matilda',
          'Rudey' => 'Rudolphus',
          'Bettie' => 'Elizabeth',
          'Levie' => 'Aleva',
          'Debbie' => 'Deborah',
          'Mac' => 'Malcolm',
          'Asahel' => 'Asaph',
          'Donia' => 'Fredonia',
          'Nat' => 'Nathaniel',
          'Clo' => 'Chloe',
          'Antonio' => 'Anthony',
          'Augustus' => 'Augustina',
          'Patty' => 'Patricia',
          'Maggie' => 'Margarita',
          'Maisie' => 'Margarita',
          'Seymore' => 'Seymour',
          'John' => 'Jonathan',
          'Ells' => 'Elwood',
          'Jessica' => 'Jessie',
          'Steve' => 'Steven',
          'Quillie' => 'Aquilla',
          'Britt' => 'Brittany',
          'Toby' => 'Tobias',
          'Rubey' => 'Reuben',
          'Jacklin' => 'Jacqueline',
          'Glorey' => 'Gloria',
          'Eli' => 'Elisha',
          'Tessie' => 'Theresa',
          'Bridgey' => 'Bridget',
          'Rosa' => 'Rosalyn',
          'Silver' => 'Sylvester',
          'Liza' => 'Elizabeth',
          'Claire' => 'Clarissa',
          'Nace' => 'Ignatzio',
          'Loomie' => 'Salome',
          'Trix' => 'Beatrice',
          'Crissie' => 'Kristine',
          'Faye' => 'Faith',
          'Lotty' => 'Carlotta',
          'Albertine' => 'Alberta',
          'Ford' => 'Crawford',
          'Fritz' => 'Frederik',
          'Pherbia' => 'Pheriba',
          'Franci' => 'Francine',
          'Midge' => 'Margarita',
          'Shar' => 'Sharon',
          'Vergey' => 'Virginia',
          'Phillie' => 'Adelphia',
          'Epsey' => 'Artelepsa',
          'Zaddie' => 'Arzada',
          'Lena' => 'Magdalena',
          'Bradey' => 'Broderick',
          'Than' => 'Nathaniel',
          'Nicki' => 'Nicole',
          'Sudy' => 'Susannah',
          'Sabby' => 'Sabrina',
          'Trish' => 'Patricia',
          'Fel' => 'Felicia',
          'Hepsibah' => 'Hepsabah',
          'Zadey' => 'Isaiah',
          'Louie' => 'Louis',
          'Day' => 'David',
          'Pasoony' => 'Parthenia',
          'Ote' => 'Otis',
          'Daisie' => 'Margaret',
          'Elouise' => 'Lousie',
          'Alisha' => 'Alice',
          'Ona' => 'Yeona',
          'Effy' => 'Euphemia',
          'Dollie' => 'Dorothy',
          'Nappy' => 'Napoleon',
          'Christine' => 'Christiana',
          'Lanny' => 'Roland',
          'Amos' => 'Moses',
          'Coco' => 'Cory',
          'Tommey' => 'Thomas',
          'Roland' => 'Orlando',
          'Fitz' => 'Fitzgerald',
          'Rox' => 'Roxane',
          'Lem' => 'Lemuel',
          'Honie' => 'Honora',
          'Thom' => 'Thomas',
          'Evie' => 'Evelyn',
          'Tori' => 'Victoria',
          'Perrey' => 'Pelegrine',
          'Parmelia' => 'Amelia',
          'Pasoonie' => 'Parthenia',
          'Hepsy' => 'Hepsabeth',
          'Rita' => 'Margarita',
          'Thys' => 'Matthew',
          'Tim' => 'Timothy',
          'Thomasa' => 'Thomasine',
          'Peddie' => 'Experience',
          'Melia' => 'Amelia',
          'Darry' => 'Darlene',
          'Hepsie' => 'Hepsabah',
          'Lenney' => 'Leonard',
          'Edgar' => 'Edward',
          'Suchie' => 'Susannah',
          'Susan' => 'Susannah',
          'Lawrie' => 'Lawrence',
          'Hily' => 'Hiram',
          'Tracy' => 'Theresa',
          'Dre' => 'Sondra',
          'Sydney' => 'Sidney',
          'Eddie' => 'Edward',
          'Zander' => 'Alexander',
          'Marilyn' => 'Mary',
          'Tobie' => 'Tobias',
          'Theodrick' => 'Theodore',
          'Maddi' => 'Matilda',
          'Dickon' => 'Richard',
          'Donnie' => 'Donald',
          'Chick' => 'Charles',
          'Katarina' => 'Katherine',
          'Tish' => 'Patricia',
          'Tomar' => 'Thomas',
          'Norbey' => 'Norbert',
          'Marcy' => 'Martha',
          'Permelia' => 'Amelia',
          'Willie' => 'Willis',
          'Mossy' => 'Maurice',
          'Bernard' => 'Barnabas',
          'Ticy' => 'Theresa',
          'Nellie' => 'Petronella',
          'Almena' => 'Philomena',
          'Jasper' => 'Casper',
          'Mellie' => 'Permelia',
          'Kester' => 'Christopher',
          'Christy' => 'Christine',
          'Waitie' => 'Waitstill',
          'Theotric' => 'Theodore',
          'Waitey' => 'Waitstill',
          'Etc.' => 'Samantha',
          'Tashie' => 'Tasha',
          'Jay' => 'John',
          'Dee' => 'Dorothy',
          'Monty' => 'Montgomery',
          'Percie' => 'Percival',
          'Floss' => 'Florence',
          'Gatsy' => 'Augustus',
          'Pheriba' => 'Pharaba',
          'Luke' => 'Lucias',
          'Baissy' => 'Elizabeth',
          'Babby' => 'Barbara',
          'Helmie' => 'Wilhelmina',
          'Rube' => 'Reuben',
          'Alexander' => 'Alexandria',
          'Leffey' => 'Lafayette',
          'Leafa' => 'Relief',
          'Wilie' => 'William',
          'Arie' => 'Arielle',
          'Quilley' => 'Aquilla',
          'Cinthia' => 'Cynthia',
          'Anse' => 'Anselm',
          'Phoeny' => 'Tryphena',
          'Marietta' => 'Mary',
          'Sukie' => 'Sarah',
          'Hittey' => 'Mehitabel',
          'Kathryn' => 'Katherine',
          'Erick' => 'Roderick',
          'Dossie' => 'Eudoris',
          'Rosalinda' => 'Rosalyn',
          'Irwin' => 'Erwin',
          'Shary' => 'Sharon',
          'Adolphus' => 'Rudolphus',
          'Shelton' => 'Sheldon',
          'Alec' => 'Alexander',
          'Andrea' => 'Andrew',
          'Rob' => 'Robin',
          'Rena' => 'Serena',
          'Jan' => 'Jennifer',
          'Telly' => 'Aristotle',
          'Richy' => 'Richard',
          'Marica' => 'Mary',
          'Haley' => 'Mahala',
          'Harman' => 'Herman',
          'Sandy' => 'Sanford',
          'Vic' => 'Victor',
          'Kersty' => 'Christiana',
          'Finny' => 'Phineas',
          'Gencey' => 'Genevieve',
          'Rick' => 'Richard',
          'Katy' => 'Katherine',
          'Solley' => 'Solomon',
          'Celia' => 'Celeste',
          'Lyn' => 'Marilyn',
          'Bitsey' => 'Elizabeth',
          'Susie' => 'Susannah',
          'Bertie' => 'Gilbert',
          'Iggey' => 'Ignatius',
          'Quint' => 'Quince',
          'Mally' => 'Malachi',
          'Daphey' => 'Daphne',
          'Cager' => 'Micajah',
          'Norry' => 'Honora',
          'Emiline' => 'Emeline',
          'Oswald' => 'Waldo',
          'Brey' => 'Bridget',
          'Vest' => 'Sylvester',
          'Shery' => 'Sharon',
          'Marion' => 'Mary',
          'Hepsey' => 'Hepsabah',
          'Joannah' => 'Joanna',
          'Daph' => 'Daphne',
          'Euy' => 'Eugenia',
          'Carolina' => 'Caroline',
          'Jeff' => 'Jeffrey',
          'Drew' => 'Andrew',
          'Betsey' => 'Elizabeth',
          'Suzey' => 'Susannah',
          'Alfreda' => 'Alfred',
          'Christey' => 'Christiana',
          'Cheryl' => 'Sharon',
          'Xan' => 'Alexandria',
          'Marianna' => 'Maryanne',
          'Elicia' => 'Alice',
          'Vickie' => 'Victoria',
          'Norm' => 'Norman',
          'Gerty' => 'Gertrude',
          'Juder' => 'Judah',
          'Jem' => 'James',
          'Paddy' => 'Patrick',
          'Benjie' => 'Benjamin',
          'Jed' => 'Jedediah',
          'Micah' => 'Michael',
          'Birdey' => 'Roberta',
          'Bonney' => 'Bonita',
          'Fina' => 'Rufina',
          'Lissia' => 'Alyssa',
          'Kris' => 'Kristopher',
          'Bette' => 'Elizabeth',
          'Edmund' => 'Edward',
          'Ham' => 'Hamilton',
          'Sarai' => 'Sarah',
          'Gatty' => 'Gertrude',
          'Cage' => 'Micajah',
          'Laurie' => 'Lawrence',
          'Lessey' => 'Celeste',
          'Kym' => 'Kimberly',
          'Conny' => 'Cornelia',
          'Kasie' => 'Casey',
          'Mattie' => 'Martha',
          'Wendy' => 'Gwendolyn',
          'Lila' => 'Lillian',
          'Zachey' => 'Zachariah',
          'Juny' => 'Junior',
          'Kittie' => 'Kathryn',
          'Cat' => 'Kathryn',
          'Ronny' => 'Veronica',
          'Caddy' => 'Caroline',
          'Lainey' => 'Elaine',
          'Doda' => 'Dorothy',
          'Margaretha' => 'Margaret',
          'Danial' => 'Daniel',
          'Babbie' => 'Barbara',
          'Ree' => 'Orilla',
          'Mindie' => 'Arminda',
          'Adelia' => 'Adelaide',
          'Sonnie' => 'Sondra',
          'Onnie' => 'Iona',
          'Roxanna' => 'Roseanne',
          'Lissa' => 'Melissa',
          'Annie' => 'Stephanie',
          'Glory' => 'Gloria',
          'Drina' => 'Alexandria',
          'Happy' => 'Karonhappuck',
          'Phena' => 'Tryphena',
          'Roseanna' => 'Roseanne',
          'Gattey' => 'Gertrude',
          'Nikkie' => 'Nicolena',
          'Mabel' => 'Mehitabel',
          'Heidey' => 'Adelaide',
          'Sally' => 'Sarah',
          'Virgey' => 'Virginia',
          'Bridgie' => 'Bridget',
          'Sharrie' => 'Sharon',
          'Ag' => 'Agatha',
          'Gail' => 'Abigail',
          'Sha' => 'Sharon',
          'Phil' => 'Philip',
          'Tilda' => 'Matilda',
          'Rolley' => 'Roland',
          'Creasy' => 'Lucretia',
          'Fanny' => 'Frances',
          'Hodgekin' => 'Roger',
          'Lura' => 'Lurana',
          'Brose' => 'Ambrose',
          'Lydy' => 'Linda',
          'Vi' => 'Vivian',
          'Mervyn' => 'Marvin',
          'Bill' => 'Willis',
          'Carol' => 'Carolyn',
          'Val' => 'Valerie',
          'Ki' => 'Hezekiah',
          'Zeb' => 'Zebulon',
          'Nan' => 'Nanette',
          'May' => 'Mary',
          'Margy' => 'Margaret',
          'Sharey' => 'Sharon',
          'Manny' => 'Manuel',
          'Bud' => 'William',
          'Lewis' => 'Louis',
          'Kristey' => 'Christiana',
          'Happey' => 'Karonhappuck',
          'Janice' => 'Jane',
          'Chance' => 'Chauncey',
          'Hessie' => 'Hester',
          'Bat' => 'Bartholomew',
          'Halley' => 'Mahalla',
          'Dyce' => 'Aphrodite',
          'Vinson' => 'Vincent',
          'Milly' => 'Permelia',
          'Thenie' => 'Parthenia',
          'Tasha' => 'Natasha',
          'Irv' => 'Irving',
          'Rinae' => 'Catherine',
          'Dickie' => 'Richard',
          'Virgie' => 'Virginia',
          'Archie' => 'Archibald',
          'Suzanne' => 'Susannah',
          'Mitchell' => 'Michael',
          'Heidie' => 'Adelaide',
          'Jereme' => 'Jeremiah',
          'Ed' => 'Edwin',
          'Prudy' => 'Prudence',
          'Eleck' => 'Alexander',
          'Parsuny' => 'Parthenia',
          'Dolley' => 'Dorothy',
          'Desirie' => 'Desiree',
          'Christopher' => 'Christian',
          'Jeremie' => 'Jeremiah',
          'Suzy' => 'Suzanne',
          'Pheny' => 'Josephine',
          'Dosey' => 'Eudoris',
          'Temera' => 'Tamara',
          'Nance' => 'Nancy',
          'Lilabet' => 'Elizabeth',
          'Vanney' => 'Vanessa',
          'Monte' => 'Monteleon',
          'Rich' => 'Richard',
          'Iggie' => 'Ignatius',
          'Tricia' => 'Patricia',
          'Percy' => 'Percival',
          'Maddie' => 'Matilda',
          'Vicy' => 'Lewvisa',
          'Jayhugh' => 'John',
          'Albert' => 'Elbert',
          'Geoffrey' => 'Jeffrey',
          'Cathey' => 'Katherine',
          'Olive' => 'Olivia',
          'Rose' => 'Rosalyn',
          'Lizabeth' => 'Elizabeth',
          'Paddey' => 'Patrick',
          'Charlie' => 'Charlotte',
          'Sha-sha' => 'Shaina',
          'Emm' => 'Emeline',
          'Lawry' => 'Lawrence',
          'Mehetable' => 'Mehitabel',
          'Neil' => 'Cornelius',
          'Syd' => 'Sidney',
          'Moira' => 'Mary',
          'Nabbey' => 'Abigail',
          'Jules' => 'Julian',
          'Minnie' => 'Wilhelmina',
          'Dirch' => 'Derrick',
          'Birdy' => 'Roberta',
          'Nappie' => 'Napoleon',
          'Len' => 'Leonard',
          'Olly' => 'Oliver',
          'Bell' => 'Belinda',
          'Dosy' => 'Eudoris',
          'Nowell' => 'Noel',
          'Kimberley' => 'Kimberly',
          'Walley' => 'Wallace',
          'Berney' => 'Barnabas',
          'Nancy' => 'Annie',
          'Life' => 'Eliphalel',
          'Nib' => 'Isabellea',
          'Mert' => 'Myrtle',
          'Ina' => 'Lavinia',
          'Judie' => 'Judith',
          'Meus' => 'Bartholomew',
          'Emmey' => 'Emeline',
          'Solly' => 'Solomon',
          'Cathie' => 'Katherine',
          'Desrey' => 'Desiree',
          'Isabelle' => 'Isabella',
          'Filip' => 'Philip',
          'Alexis' => 'Alexander',
          'Cyphorus' => 'Onicyphorous',
          'Mima' => 'Jemima',
          'Gerie' => 'Geraldine',
          'Lise' => 'Elizabeth',
          'Odie' => 'Lillian',
          'Levey' => 'Aleva',
          'Gency' => 'Genevieve',
          'Augey' => 'Augusta',
          'Effey' => 'Euphemia',
          'Marjorie' => 'Margaret',
          'Dan' => 'Sheridan',
          'Tamarra' => 'Tamara',
          'Lester' => 'Leslie',
          'Luanne' => 'Luann',
          'Rilly' => 'Orilla',
          'Rissa' => 'Marissa',
          'Rasmus' => 'Erasmus',
          'Wyncha' => 'Louvinia',
          'Fred' => 'Wilfred',
          'Larry' => 'Lawrence',
          'Bo' => 'Boetius',
          'Zach' => 'Zachary',
          'Jud' => 'Judson',
          'Adeline' => 'Aline',
          'Gina' => 'Virginia',
          'Cordy' => 'Cory',
          'Kat' => 'Katherine',
          'Nap' => 'Napoleon',
          'Gusie' => 'Augustina',
          'Mossey' => 'Maurice',
          'Flick' => 'Felicity',
          'Creasie' => 'Lucretia',
          'Honor' => 'Leonore',
          'Adela' => 'Della',
          'Rana' => 'Lorraine',
          'Tillie' => 'Tilford',
          'Kimmey' => 'Kimberly',
          'Gabe' => 'Gabriel',
          'Jettie' => 'Josetta',
          'Kiah' => 'Hezekiah',
          'Emmy' => 'Emily',
          'Stacy' => 'Eustacia',
          'Hal' => 'Howard',
          'Poney' => 'Napoleon',
          'Maggy' => 'Margaret',
          'Josephine' => 'Pheney',
          'Vonna' => 'Yvonne',
          'Cille' => 'Lucille',
          'Seny' => 'Eseneth',
          'Bibbit' => 'Mary elizabeth',
          'Angey' => 'Angela',
          'Merlyn' => 'Merlin',
          'Ryan' => 'Brian',
          'Tensy' => 'Hortense',
          'Katie' => 'Kathleen',
          'Rae' => 'Rachel',
          'Baissie' => 'Elizabeth',
          'Sibby' => 'Sibbilla',
          'Tobi' => 'Tobias',
          'Jen' => 'Jennifer',
          'Kristie' => 'Christiana',
          'Zady' => 'Isaiah',
          'Ola' => 'Viola',
          'Nicky' => 'Nicole',
          'Sherie' => 'Sharon',
          'Bella' => 'Isabellea',
          'Hosy' => 'Hosea',
          'Karel' => 'Charles',
          'Nicole' => 'Nicolena',
          'Steffie' => 'Stephanie',
          'Izzey' => 'Isidore',
          'Maurie' => 'Maurice',
          'Jincey' => 'Jane',
          'Missy' => 'Melissa',
          'Slie' => 'Sylvester',
          'Leafie' => 'Relief',
          'Belle' => 'Isabellea',
          'Hosey' => 'Hosea',
          'Lettice' => 'Letitia',
          'Norbie' => 'Norbert',
          'Vangie' => 'Evangeline',
          'Ginnie' => 'Virginia',
          'Maggi' => 'Margaret',
          'Gretta' => 'Margaret',
          'Jinie' => 'Virginia',
          'Rea' => 'Andrea',
          'Terri' => 'Therese',
          'Heidy' => 'Adelaide',
          'Ross' => 'Roscoe',
          'Beverly' => 'Beverly',
          'Rupert' => 'Robert',
          'Charlotta' => 'Lotty',
          'Kasy' => 'Casey',
          'Dick' => 'Zadock',
          'Dany' => 'Danielle',
          'Dode' => 'Dorothy',
          'Dennie' => 'Dennis',
          'Jacklyn' => 'Jacqueline',
          'Creasey' => 'Lucretia',
          'Jinsey' => 'Jane',
          'Shane' => 'Shaun',
          'Leon' => 'Napoleon',
          'Sydnie' => 'Sidney',
          'Desrie' => 'Desiree',
          'Ky' => 'Hezekiah',
          'Terence' => 'Terrance',
          'Laury' => 'Lauryn',
          'Lr' => 'Leroy',
          'Nibbie' => 'Isabella',
          'Hop' => 'Hopkins',
          'Titia' => 'Letitia',
          'Lilley' => 'Lillian',
          'Mavery' => 'Mavine',
          'Doug' => 'Douglas',
          'Christian' => 'Christopher',
          'Laffy' => 'Lafayette',
          'Sammie' => 'Samuel',
          'Trudy' => 'Gertrude',
          'Biddy' => 'Bridget',
          'Mur' => 'Muriel',
          'Fidelia' => 'Delia',
          'Lisa' => 'Melissa',
          'Roxey' => 'Roseanne',
          'Dina' => 'Geraldine',
          'Janyce' => 'Jane',
          'Angeline' => 'Angela',
          'Margaretta' => 'Margaret',
          'Bess' => 'Elizabeth',
          'Dorey' => 'Theodore',
          'Jonathan' => 'Nathaniel',
          'Lonny' => 'Lawrence',
          'Sandra' => 'Cassandra',
          'Anabelle' => 'Arabella',
          'Teddi' => 'Theodore',
          'Mitch' => 'Mitchell',
          'Alex' => 'Alexandra',
          'Myrtie' => 'Myrtle',
          'Step' => 'Stephen',
          'Frank' => 'Franklin',
          'Nita' => 'Juanita',
          'Mary' => 'Mitzi',
          'Tick' => 'Felicity',
          'Mick' => 'Michael',
          'Senie' => 'Eseneth',
          'Obed' => 'Obedience',
          'Betsy' => 'Elizabeth',
          'Cindy' => 'Lucinda',
          'Delley' => 'Deliverance',
          'Vonney' => 'Veronica',
          'Mal' => 'Malcolm',
          'Sig' => 'Sigismund',
          'Humie' => 'Posthuma',
          'Xandra' => 'Alexander',
          'Catherine' => 'Katherine',
          'Shellie' => 'Rochelle',
          'Liley' => 'Silence',
          'Paddie' => 'Patrick',
          'Clarice' => 'Clarissa',
          'Lorry' => 'Lawrence',
          'Vonnie' => 'Veronica',
          'Deb' => 'Deborah',
          'Salley' => 'Sarah',
          'Valerey' => 'Valentina',
          'Denyse' => 'Denise',
          'Karl' => 'Charles',
          'Micky' => 'Miriam',
          'Danni' => 'Danielle',
          'Joan' => 'Joanna',
          'Ned' => 'Theodore',
          'Josepha' => 'Josephine',
          'Dicky' => 'Richard',
          'Epaphroditus' => 'Aphrodite',
          'Gatsie' => 'Augustus',
          'Kymberly' => 'Kimberly',
          'Sharyn' => 'Sharon',
          'Dwayne' => 'Duane',
          'Joann' => 'Joanna',
          'Di' => 'Diane',
          'Franky' => 'Veronica',
          'Ossie' => 'Oswald',
          'Elisha' => 'Alice',
          'Beda' => 'Obedience',
          'Berny' => 'Barnabas',
          'Nicolene' => 'Nicolena',
          'Berry' => 'Littleberry',
          'Kezzy' => 'Keziah',
          'Erika' => 'Frederica',
          'Zelphie' => 'Zelphia',
          'Tommie' => 'Tomas',
          'Dyer' => 'Obadiah',
          'Dilly' => 'Deliverance',
          'Beverley' => 'Beverly',
          'Ado' => 'Rudolphus',
          'Cassandra' => 'Alexandria',
          'Vina' => 'Melvina',
          'Andi' => 'Alexander',
          'Geoffrie' => 'Jefferson',
          'Antone' => 'Antonia',
          'Connie' => 'Constance',
          'Jill' => 'Julia',
          'Tempey' => 'Temperance',
          'Sher' => 'Sheridan',
          'Vessie' => 'Sylvester',
          'Vangey' => 'Evangeline',
          'Jincie' => 'Jane',
          'Harold' => 'Harry',
          'Pam' => 'Pamela',
          'Linette' => 'Linda',
          'Debbey' => 'Deborah',
          'Hugo' => 'Hubert',
          'Sis' => 'Frances',
          'Lodi' => 'Melody',
          'Della' => 'Rhodella',
          'Abby' => 'Abigail',
          'Bartel' => 'Bartholomew',
          'Antoinette' => 'Anthony',
          'Ticie' => 'Theresa',
          'Lennie' => 'Leonard',
          'Rodie' => 'Rhoda',
          'Kristine' => 'Christiana',
          'Dank' => 'Daniel',
          'Nolly' => 'Olivia',
          'Sula' => 'Ursula',
          'Trissy' => 'Theresa',
          'Ken' => 'Mckenna',
          'Kimmy' => 'Kimberly',
          'Rhodie' => 'Rhodella',
          'Ruminta' => 'Armida',
          'Leafy' => 'Relief',
          'Jaqui' => 'Jacqueline',
          'Lish' => 'Elisha',
          'Lige' => 'Elijah',
          'Vergy' => 'Virginia',
          'Dacie' => 'Candace',
          'Lib' => 'Elizabeth',
          'Lorrie' => 'Lorraine',
          'Vicey' => 'Lewvisa',
          'Samantha' => 'Samuel',
          'Barbary' => 'Barbara',
          'Elnora' => 'Eleanor',
          'Ferdey' => 'Ferdinand',
          'Willis' => 'William',
          'Tom' => 'Tomas',
          'Vessy' => 'Sylvester',
          'Leafey' => 'Relief',
          'Prissie' => 'Priscilla',
          'Bede' => 'Obedience',
          'Hugh' => 'Jehu',
          'Lyddy' => 'Linda',
          'Charly' => 'Charles',
          'Lina' => 'Emeline',
          'Chesly' => 'Chesley',
          'Tanny' => 'Tanafra',
          'Paula' => 'Paulina',
          'Tobe' => 'Tobias',
          'Kitty' => 'Kathryn',
          'Ellender' => 'Helena',
          'Peggy' => 'Margaret',
          'Agnes' => 'Nancy',
          'Gabby' => 'Gabrielle',
          'Malachey' => 'Malcolm',
          'Cece' => 'Celia',
          'Jincy' => 'Jane',
          'Cordelia' => 'Delia',
          'Adolph' => 'Adolphus',
          'Cordie' => 'Cordelia',
          'Mitty' => 'Submit',
          'Corney' => 'Cornelia',
          'Zaddi' => 'Arzada',
          'Mike' => 'Michael',
          'Ty' => 'Tyson',
          'Molly' => 'Mary',
          'Mate' => 'Mary',
          'Jedidiah' => 'Jedediah',
          'Nicolina' => 'Nicolena',
          'Lillie' => 'Lillian',
          'Angie' => 'Angela',
          'Philadelphia' => 'Delpha',
          'Minerva' => 'Manerva',
          'Anna' => 'Savannah',
          'Kay' => 'Kendra',
          'Ode' => 'Otis',
          'Lois' => 'Lousie',
          'Nathan' => 'Nathaniel',
          'Fenee' => 'Euphrosina',
          'Sharrey' => 'Sharon',
          'Van' => 'Vanessa',
          'Xina' => 'Christine',
          'Esther' => 'Hester',
          'Bettey' => 'Elizabeth',
          'Andre' => 'Anderson',
          'Archelous' => 'Archibald',
          'Assene' => 'Asenath',
          'Kingston' => 'King',
          'Verna' => 'Laverne',
          'Lonzo' => 'Alonzo',
          'Maddy' => 'Matilda',
          'Ernie' => 'Ernst',
          'Ardey' => 'Ardeshir',
          'Ruby' => 'Reuben',
          'Kerstey' => 'Christiana',
          'Corny' => 'Cornelia',
          'Rustie' => 'Russell',
          'Abertina' => 'Alberta',
          'Patricia' => 'Patrick',
          'Webb' => 'Webster',
          'Sulie' => 'Ursula',
          'Vick' => 'Victor',
          'Tennie' => 'Tennessee',
          'Diccon' => 'Richard',
          'Daphy' => 'Daphne',
          'Ophi' => 'Theophilus',
          'Winifred' => 'Jennifer',
          'Von' => 'Levone',
          'Armanda' => 'Amanda',
          'Kezzey' => 'Keziah',
          'Jane' => 'Virginia',
          'Ginger' => 'Virginia',
          'Theny' => 'Parthenia',
          'Howey' => 'Howard',
          'Silla' => 'Sarilla',
          'Marcia' => 'Mary',
          'Tammey' => 'Tamara',
          'Aurilla' => 'Aurelia',
          'Katherina' => 'Katherine',
          'Jack' => 'John',
          'Polly' => 'Pauline',
          'Sharie' => 'Sharon',
          'Dob' => 'Robert',
          'Zada' => 'Alzada',
          'Josey' => 'Josephine',
          'Kc' => 'Casey',
          'Finnie' => 'Phineas',
          'Carla' => 'Carlotta',
          'Killis' => 'Archilles',
          'Alphus' => 'Alphinias',
          'Jc' => 'Jane',
          'Hobkin' => 'Robert',
          'Nony' => 'Joanna',
          'Lee' => 'Leroy',
          'Saul' => 'Solomon',
          'Babbey' => 'Barbara',
          'Hannah' => 'Susannah',
          'Laffey' => 'Lafayette',
          'Torrey' => 'Victoria',
          'Middie' => 'Madeline',
          'Nicodemus' => 'Nicholas',
          'Wen' => 'Wendy',
          'Tommy' => 'Tomas',
          'Mave' => 'Mavine',
          'Lottie' => 'Charlotte',
          'Tabbey' => 'Tabitha',
          'Xena' => 'Christiana',
          'Neppie' => 'Penelope',
          'Ada' => 'Adelaide',
          'Matthias' => 'Matthew',
          'Marg' => 'Marjory',
          'Rubie' => 'Reuben',
          'Tessey' => 'Theresa',
          'Virg' => 'Virgil',
          'Iggy' => 'Ignatzio',
          'Sley' => 'Sylvester',
          'Torie' => 'Victoria',
          'Ophie' => 'Theophilus',
          'Thursa' => 'Theresa',
          'Beckie' => 'Rebecca',
          'Clay' => 'Clayton',
          'Fanney' => 'Frances',
          'Cam' => 'Campbell',
          'Krissey' => 'Kristel',
          'Steven' => 'Stephen',
          'Jackson' => 'John',
          'Aggy' => 'Augustina',
          'Louise' => 'Lois',
          'Nabby' => 'Abigail',
          'Kid' => 'Keziah',
          'Bobbie' => 'Roberta',
          'Margauerite' => 'Margarita',
          'Dellie' => 'Deliverance',
          'Sybrina' => 'Sabrina',
          'Dom' => 'Dominick',
          'Joy' => 'Joyce',
          'Zella' => 'Zelphia',
          'Orphelia' => 'Ophelia',
          'Bias' => 'Tobias',
          'Elenora' => 'Eleanor',
          'Kerstie' => 'Christiana',
          'Elly' => 'Elwood',
          'Delbert' => 'Adelbert',
          'Alla' => 'Alexandria',
          'Cene' => 'Cyrenius',
          'Karon' => 'Karonhappuck',
          'Tessa' => 'Theresa',
          'Flossey' => 'Florence',
          'Vally' => 'Valentina',
          'Ron' => 'Veronica',
          'Gustus' => 'Augustus',
          'Thriza' => 'Theresa',
          'Dannie' => 'Danielle',
          'Gib' => 'Gilbert',
          'Levy' => 'Aleva',
          'Lizzey' => 'Elizabeth',
          'Arley' => 'Arlene',
          'Nole' => 'Nicole',
          'Wint' => 'Winton',
          'Appey' => 'Appoline',
          'Susey' => 'Susannah',
          'Dirk' => 'Derek',
          'Nicey' => 'Vernisee',
          'Pennie' => 'Penelope',
          'Baldo' => 'Archibald',
          'Edny' => 'Edna',
          'Tammy' => 'Tamarra',
          'Suchey' => 'Susannah',
          'Delia' => 'Fidelia',
          'Gene' => 'Eugene',
          'Osaforum' => 'Onicyphorous',
          'Claes' => 'Nicholas',
          'Charley' => 'Charles',
          'Dite' => 'Aphrodite',
          'Ec' => 'Alexander',
          'Liba' => 'Libuse',
          'Wally' => 'Walter',
          'Mags' => 'Margaret',
          'Charlotte' => 'Lotty',
          'Alice' => 'Elsie',
          'Gum' => 'Montgomery',
          'Lonney' => 'Lawrence',
          'Roxane' => 'Roseanne',
          'Bryant' => 'Brian',
          'Bernie' => 'Bernard',
          'Onny' => 'Iona',
          'Humy' => 'Posthuma',
          'Barny' => 'Barnabas',
          'Myrt' => 'Myrtle',
          'Fredricka' => 'Frederica',
          'Lulu' => 'Louise',
          'Link' => 'Lincoln',
          'Moll' => 'Mary',
          'Bessie' => 'Elizabeth',
          'Vanny' => 'Vanessa',
          'Ronni' => 'Veronica',
          'Lizzie' => 'Elizabeth',
          'Mossie' => 'Maurice',
          'Brad' => 'Bradley',
          'Moe' => 'Moses',
          'Mamey' => 'Mary',
          'Gwen' => 'Gwendolyn',
          'Renaldo' => 'Reginald',
          'Jeremy' => 'Jeremiah',
          'Zel' => 'Zelphia',
          'Arney' => 'Arnold',
          'Lodey' => 'Melody',
          'Roy' => 'Royall',
          'Suchy' => 'Susannah',
          'Cecilie' => 'Cecilia',
          'Nikkey' => 'Nicolena',
          'Penny' => 'Penelope',
          'Tibby' => 'Isabella',
          'Tippy' => 'Tipton',
          'Ellie' => 'Eleanor',
          'Lenhart' => 'Leonard',
          'Fie' => 'Philander',
          'Cole' => 'Nicole',
          'Wallie' => 'Walter',
          'Ev' => 'Evelyn',
          'Nibby' => 'Isabella',
          'Margerie' => 'Margaret',
          'Barbey' => 'Barbara',
          'Fate' => 'Lafayette',
          'Ren' => 'Lauren',
          'Mina' => 'Wilhelmina',
          'Hermy' => 'Hermione',
          'Reg' => 'Reginald',
          'Ian' => 'John',
          'Brady' => 'Broderick',
          'Cassie' => 'Catherine',
          'Norby' => 'Norbert',
          'Biddie' => 'Obedience',
          'Vester' => 'Sylvester',
          'Sean' => 'Shaun',
          'Hodge' => 'Roger',
          'Cathleen' => 'Katherine',
          'Louanne' => 'Luann',
          'Nessy' => 'Agnes',
          'Sina' => 'Rosina',
          'Amabel' => 'Mehitabel',
          'Nannie' => 'Nancy',
          'Ardie' => 'Ardeshir',
          'Viola' => 'Violet',
          'Gatsey' => 'Augustus',
          'Ansey' => 'Andrew',
          'Bree' => 'Aubrey',
          'Brody' => 'Broderick',
          'Billy' => 'William',
          'Eliza' => 'Louise',
          'Marjorey' => 'Margaret',
          'Margey' => 'Margaret',
          'Louetta' => 'Lousie',
          'Hen' => 'Henry',
          'Leffy' => 'Lafayette',
          'Geny' => 'Eugenia',
          'Annette' => 'Anna',
          'Lb' => 'Littleberry',
          'Tobey' => 'Tobias',
          'Davy' => 'David',
          'Abbey' => 'Abigail',
          'Sady' => 'Sarah',
          'Shirl' => 'Shirley',
          'Geney' => 'Eugenia',
          'Crate' => 'Socrates',
          'Ala' => 'Alexander',
          'Abram' => 'Abraham',
          'Johnny' => 'Johannes',
          'Chellie' => 'Rochelle',
          'Ricka' => 'Frederica',
          'Simon' => 'Simeon',
          'Freddie' => 'Winifred',
          'Aze' => 'Azariah',
          'Ury' => 'Uriah',
          'Carm' => 'Carmon',
          'Quilla' => 'Tranquilla',
          'Vonny' => 'Veronica',
          'Evan' => 'Evangeline',
          'Mock' => 'Democrates',
          'Aline' => 'Adaline',
          'Tentie' => 'Content',
          'Syl' => 'Sylvester',
          'Peddey' => 'Experience',
          'Rustey' => 'Russell',
          'Jimmie' => 'James',
          'Sammey' => 'Samuel',
          'Siller' => 'Priscilla',
          'Donna' => 'Fredonia',
          'Hessey' => 'Hester',
          'Ruffie' => 'Rufus',
          'Evelina' => 'Evelyn',
          'Gabriella' => 'Gabrielle',
          'Kerie' => 'Caroline',
          'Middey' => 'Madeline',
          'Biff' => 'William',
          'Mathilda' => 'Matilda',
          'Essy' => 'Estella',
          'Desie' => 'Desiree',
          'Kingsley' => 'King',
          'Jaques' => 'John',
          'Freddy' => 'Manfred',
          'Lydie' => 'Linda',
          'Richie' => 'Richard',
          'Howy' => 'Howard',
          'Malachie' => 'Malcolm',
          'Patsy' => 'Patrick',
          'Libby' => 'Elizabeth',
          'Kitsie' => 'Katherine',
          'Abiah' => 'Abijah',
          'Kenjie' => 'Kendra',
          'Gertey' => 'Gertrude',
          'Darey' => 'Darwin',
          'Netty' => 'Antoinette',
          'Alison' => 'Alice',
          'Bessey' => 'Elizabeth',
          'Vangy' => 'Evangeline',
          'Ivan' => 'John',
          'Ophy' => 'Theophilus',
          'Louisa' => 'Lousie',
          'Christie' => 'Kristine',
          'Ceall' => 'Lucille',
          'Toni' => 'Antoinette',
          'Alf' => 'Alfred',
          'Franz' => 'Francis',
          'Densy' => 'Prudence',
          'Tippey' => 'Tipton',
          'Adoph' => 'Rudolphus',
          'Bethia' => 'Elizabeth',
          'Larrie' => 'Lawrence',
          'Ozzey' => 'Oswald',
          'Gordo' => 'Gordon',
          'Sene' => 'Asenath',
          'Jess' => 'Jessie',
          'Ib' => 'Isabellea',
          'Ossy' => 'Oswald',
          'Winnet' => 'Winifred',
          'Jiney' => 'Virginia',
          'Ibby' => 'Elizabeth',
          'Zachie' => 'Zachariah',
          'Cybilla' => 'Isabellea',
          'Gord' => 'Gordon',
          'Moss' => 'Moses',
          'Ansel' => 'Anselm',
          'Dee dee' => 'Nadine',
          'Peggey' => 'Margaret',
          'Nonie' => 'Nora',
          'Tipsie' => 'Tipton',
          'Barbery' => 'Barbara',
          'Maisey' => 'Margaret',
          'Eben' => 'Ebenezer',
          'Harry' => 'Horace',
          'Colie' => 'Cole',
          'Jaclyn' => 'Jacqueline',
          'Nikky' => 'Nicolena',
          'Eleanor' => 'Helena',
          'Zachary' => 'Zachariah',
          'Casper' => 'Jasper',
          'Adeliza' => 'Adelaide',
          'Kenjy' => 'Kendra',
          'Baisie' => 'Elizabeth',
          'Thad' => 'Thaddeus',
          'L.b.' => 'Littleberry',
          'Tash' => 'Tasha',
          'Danny' => 'Sheridan',
          'Candie' => 'Candace',
          'Eve' => 'Manerva',
          'Vallie' => 'Valentine',
          'Bert' => 'Roberta',
          'June' => 'Junior',
          'Joanna' => 'Jean',
          'Pasooney' => 'Parthenia',
          'Reginald' => 'Reynold',
          'Phosie' => 'Tryphosia',
          'Eb' => 'Ebenezer',
          'Ray' => 'Regina',
          'Sy' => 'Sylvester',
          'Caddey' => 'Caroline',
          'Newt' => 'Newton',
          'Poley' => 'Napoleon',
          'Felty' => 'Valentine',
          'Prue' => 'Prudence',
          'Marc' => 'Marcus',
          'Augustina' => 'Augusta',
          'Serene' => 'Cyrenius',
          'Viney' => 'Louvinia',
          'Prissey' => 'Priscilla',
          'Chris' => 'Kristopher',
          'Marcie' => 'Marsha',
          'Elena' => 'Helena',
          'Al' => 'Alyssa',
          'Tad' => 'Thaddeus',
          'Dea' => 'Demerias',
          'Tess' => 'Therese',
          'Kimberlie' => 'Kimberly',
          'Teddie' => 'Theodore',
          'Gattie' => 'Gertrude',
          'Trisha' => 'Beatrice',
          'Nanny' => 'Hannah',
          'Willy' => 'Willis',
          'Randy' => 'Randolph',
          'Dave' => 'David',
          'Danie' => 'Danielle',
          'Nicy' => 'Vernisee',
          'Sherey' => 'Sharon',
          'Abe' => 'Abraham',
          'Justus' => 'Justin',
          'Sissy' => 'Celia',
          'Babs' => 'Barbara',
          'Rina' => 'Serena',
          'Bridie' => 'Bridget',
          'Karen' => 'Kathleen',
          'Helmey' => 'Wilhelmina',
          'Hebsabeth' => 'Hepsabah',
          'Lydey' => 'Linda',
          'Gill' => 'Guilford',
          'Suki' => 'Suzanne',
          'Pink' => 'Pinckney',
          'Alie' => 'Alice',
          'Lea' => 'Leanne',
          'Linney' => 'Adeline',
          'Henny' => 'Henrietta',
          'Medora' => 'Dorothy',
          'Eric' => 'Roderik',
          'Cy' => 'Onicyphorous',
          'Bri' => 'Sabrina',
          'Appy' => 'Appoline',
          'Dortha' => 'Dorothy',
          'Jehu' => 'John',
          'Merci' => 'Mercedes',
          'Gerry' => 'Gerard',
          'Raech' => 'Rachel',
          'Dilley' => 'Deliverance',
          'Lecta' => 'Electra',
          'Mo' => 'Moses',
          'Sullie' => 'Sullivan',
          'Horrie' => 'Horace',
          'Mickie' => 'Miriam',
          'Moses' => 'Amos',
          'Flossie' => 'Florence',
          'Theo' => 'Theodosia',
          'Dossy' => 'Eudoris',
          'Cassey' => 'Cassandra',
          'Sonny' => 'Samuel',
          'Dyche' => 'Aphrodite',
          'Andy' => 'Andrus',
          'Emeline' => 'Emeline',
          'Bridgy' => 'Bridget',
          'Shay' => 'Sharon',
          'Morrie' => 'Seymour',
          'Barberey' => 'Barbara',
          'Bobby' => 'Robert',
          'Archey' => 'Archibald',
          'Kill' => 'Archilles',
          'Hank' => 'Henry',
          'Ellen' => 'Helena',
          'Phyllis' => 'Philinda',
          'Janie' => 'Jane',
          'Jessie' => 'Jessica',
          'Cilla' => 'Priscilla',
          'Ali' => 'Alison',
          'Zee' => 'Zina',
          'Thaney' => 'Bethena',
          'Ally' => 'Alyssa',
          'Damaris' => 'Demerias',
          'Augy' => 'Augusta',
          'Timmy' => 'Timothy',
          'Chesley' => 'Chesley',
          'Josy' => 'Josephine',
          'Meg' => 'Megan',
          'Nick' => 'Nicodemus',
          'Yul' => 'Yulan',
          'Smittie' => 'Smith',
          'Tellie' => 'Aristotle',
          'Hob' => 'Robert',
          'Selma' => 'Anselm',
          'Seph' => 'Persephone',
          'Estelle' => 'Estella',
          'Humey' => 'Posthuma',
          'Jeanne' => 'Jeanette',
          'Zelphy' => 'Zelphia',
          'Delphina' => 'Adelphia',
          'Addy' => 'Agatha',
          'Lazar' => 'Eleazer',
          'Ginney' => 'Virginia',
          'Tenty' => 'Content',
          'Winnie' => 'Winifred',
          'Sophie' => 'Sophronia',
          'Neal' => 'Cornelius',
          'Cindie' => 'Lucinda',
          'Tallie' => 'Natalie',
          'Jock' => 'John',
          'Sly' => 'Sylvester',
          'Asa' => 'Asaph',
          'Dwane' => 'Duane',
          'Clum' => 'Columbus',
          'Flossy' => 'Florence',
          'Mantha' => 'Samantha',
          'Sadey' => 'Sarah',
          'Erna' => 'Ernestine',
          'Leo' => 'Leopold',
          'Rowland' => 'Roland',
          'Zacharey' => 'Zachariah',
          'Harty' => 'Hortense',
          'Exie' => 'Experience',
          'Didi' => 'Diane',
          'Eddy' => 'Edward',
          'Buren' => 'Vanburen',
          'Adolf' => 'Rudolphus',
          'Acuilla' => 'Aquilla',
          'Noney' => 'Joanna',
          'Phenie' => 'Parthenia',
          'Hattie' => 'Henrietta',
          'Curg' => 'Lecurgus',
          'Scottey' => 'Prescott',
          'Rex' => 'Reginald',
          'Gert' => 'Gertrude',
          'Smitty' => 'Smith',
          'Morris' => 'Maurice',
          'Deanney' => 'Geraldine',
          'Isabel' => 'Isabella',
          'Genny' => 'Gwendolyn',
          'Mees' => 'Bartholomew',
          'Irving' => 'Irvin',
          'Swene' => 'Cyrenius',
          'Fally' => 'Eliphalet',
          'Alaina' => 'Elaine',
          'Nora' => 'Leonore',
          'Cate' => 'Kathryn',
          'Zed' => 'Zedediah',
          'Car' => 'Charlotte',
          'Lolly' => 'Lillian',
          'Matty' => 'Matthias',
          'Nollie' => 'Olivia',
          'Ara' => 'Arabella',
          'Etta' => 'Loretta',
          'Louvina' => 'Lavinia',
          'Maud' => 'Matilda',
          'Hennie' => 'Henrietta',
          'Bitsie' => 'Elizabeth',
          'Mandy' => 'Miranda',
          'Tensey' => 'Hortense',
          'Maverie' => 'Mavine',
          'Lou' => 'Lucinda',
          'Kenji' => 'Kendra',
          'Eddey' => 'Edward',
          'Rhoda' => 'Rhodella',
          'Sal' => 'Solomon',
          'Gusey' => 'Augusta',
          'Barney' => 'Bernard',
          'Mel' => 'Melvin',
          'Carolyn' => 'Caroline',
          'Rudy' => 'Rudolphus',
          'Wendey' => 'Gwendolyn',
          'Barby' => 'Barbara',
          'Monna' => 'Monica',
          'Edney' => 'Edith',
          'Kymberlie' => 'Kimberly',
          'Zelphey' => 'Zelphia',
          'Peter' => 'Patrick',
          'Cheslie' => 'Chesley',
          'Clem' => 'Clementine',
          'Vince' => 'Vincent',
          'Billie' => 'William',
          'Deannie' => 'Geraldine',
          'Valley' => 'Valentina',
          'Bird' => 'Albert',
          'Candi' => 'Candace',
          'Cliff' => 'Wycliffe',
          'Frona' => 'Sophronia',
          'Judi' => 'Judith',
          'Mehitabel' => 'Mabel',
          'Alfie' => 'Alfred',
          'Sydny' => 'Sidney',
          'Viv' => 'Vivian',
          'Arny' => 'Arnold',
          'Bradlie' => 'Bradford',
          'Otha' => 'Theotha',
          'Barth' => 'Bartholomew',
          'Juda' => 'Judith',
          'Bessy' => 'Elizabeth',
          'Kenny' => 'Kenneth',
          'Jessy' => 'Jessica',
          'Hiel' => 'Jehiel',
          'Thea' => 'Althea',
          'Sophy' => 'Sophronia',
          'Claas' => 'Nicholas',
          'Letty' => 'Charlotte',
          'Prudey' => 'Prudence',
          'Teeny' => 'Parthenia',
          'Cecelie' => 'Cecilia',
          'Lucie' => 'Lucinda',
          'Kathy' => 'Kathryn',
          'Poky' => 'Pocahontas',
          'Ralph' => 'Raphael',
          'Elissa' => 'Elizabeth',
          'Peny' => 'Philipina',
          'Dary' => 'Darwin',
          'Sibbell' => 'Sibbilla',
          'Virginia' => 'Jane',
          'Sara' => 'Sarah',
          'Lum' => 'Columbus',
          'Valerie' => 'Valentina',
          'Baldey' => 'Archibald',
          'Meaka' => 'Mckenna',
          'Duty' => 'Deuteronomy',
          'Erica' => 'Frederica',
          'Jeb' => 'Jedediah',
          'Stan' => 'Stanley',
          'Dunk' => 'Duncan',
          'Debra' => 'Deborah',
          'Edith' => 'Adaline',
          'Don' => 'Donald',
          'Phosey' => 'Tryphosia',
          'Hettie' => 'Henrietta',
          'Henry' => 'Harry',
          'Nadia' => 'Nadezhda',
          'Dossey' => 'Eudoris',
          'Viny' => 'Louvenia',
          'Olph' => 'Rudolphus',
          'Tory' => 'Victoria',
          'Dilbert' => 'Delbert',
          'Lars' => 'Lawrence',
          'Fena' => 'Euphrosina',
          'Helmy' => 'Wilhelmina',
          'Derick' => 'Frederik',
          'Mae' => 'May',
          'Zadie' => 'Isaiah',
          'Mark' => 'Marcus',
          'Andria' => 'Andrea',
          'Louann' => 'Luann',
          'Trudi' => 'Gertrude',
          'Mariah' => 'Mary',
          'Nelia' => 'Cornelia',
          'Hopp' => 'Hopkins',
          'Tracey' => 'Theresa',
          'Malachy' => 'Malcolm',
          'Jaclin' => 'Jacqueline',
          'Howie' => 'Howard',
          'Fannny' => 'Nathaniel',
          'Eva' => 'Evaline',
          'Raze' => 'Erasmus',
          'Elvie' => 'Elvira',
          'Jule' => 'Julias',
          'Tris' => 'Tristram',
          'Jiny' => 'Virginia',
          'Wat' => 'Walter',
          'Delphia' => 'Philadelphia',
          'Parsunie' => 'Parthenia',
          'Jaky' => 'Jacqueline',
          'America' => 'Mary',
          'Sheryn' => 'Sharon',
          'Dillie' => 'Deliverance',
          'Reggie' => 'Reginald',
          'Tally' => 'Natalie',
          'Cera' => 'Sarah',
          'Darie' => 'Darwin',
          'Vicky' => 'Victoria',
          'Luella' => 'Ellie',
          'Kathey' => 'Katherine',
          'Mandana' => 'Amanda',
          'Delly' => 'Deliverance',
          'Ary' => 'Arielle',
          'Nell' => 'Helena',
          'Knowell' => 'Noel',
          'Kathie' => 'Katherine',
          'Krissy' => 'Kristine',
          'Hessy' => 'Hester',
          'Chet' => 'Chester',
          'Fifi' => 'Phoebe',
          'Kissey' => 'Calista',
          'Mart' => 'Martha',
          'Sammy' => 'Samuel',
          'Zaddey' => 'Arzada',
          'Debbe' => 'Deborah',
          'Denney' => 'Dennis',
          'Lily' => 'Lillian',
          'Dacey' => 'Candace',
          'Candy' => 'Candace',
          'Lucas' => 'Lucias',
          'Marti' => 'Martha',
          'Robbie' => 'Roberta',
          'Epaphroditius' => 'Aphrodite',
          'Demaris' => 'Mary',
          'Maris' => 'Demerias',
          'Pip' => 'Phillip',
          'Archy' => 'Archibald',
          'Ry' => 'Ryan',
          'Zollie' => 'Solomon',
          'Hony' => 'Honora',
          'Tensie' => 'Hortense',
          'Hence' => 'Henry',
          'Nonnie' => 'Manola',
          'Zacharie' => 'Zachariah',
          'Jo' => 'Josephine',
          'Waity' => 'Waitstill',
          'Essa' => 'Vanessa',
          'Loenore' => 'Leonora',
          'Josefa' => 'Joseph',
          'Izzie' => 'Isidore',
          'Fordy' => 'Crawford',
          'Dacy' => 'Candace',
          'Jimmy' => 'James',
          'Mell' => 'Mildred',
          'Pokey' => 'Pocahontas',
          'Crissi' => 'Kristine',
          'Livie' => 'Olivia',
          'Lola' => 'Delores',
          'Pokie' => 'Pocahontas',
          'Kissy' => 'Kristine',
          'Kimberly' => 'Kimberly',
          'Desy' => 'Desiree',
          'Maura' => 'Maureen',
          'Megan' => 'Margarita',
          'Zachy' => 'Zachariah',
          'Ez' => 'Ezekiel',
          'Erma' => 'Emily',
          'Lon' => 'Zebulon',
          'Bennie' => 'Benjamin',
          'Leve' => 'Aleva',
          'Neppey' => 'Penelope',
          'Maisy' => 'Margaret',
          'Sharry' => 'Sharon',
          'Rhody' => 'Rhodella',
          'Bradley' => 'Bradford',
          'Birdie' => 'Roberta',
          'Cecely' => 'Cecilia',
          'Nels' => 'Nelson',
          'Raff' => 'Raphael',
          'Ticey' => 'Theresa',
          'Charles' => 'Carl',
          'Walt' => 'Walter',
          'Dolly' => 'Dorothy',
          'Surry' => 'Sarah',
          'Hermie' => 'Hermione',
          'Maury' => 'Maurice',
          'Roge' => 'Roger',
          'Livy' => 'Olivia',
          'Lucia' => 'Luciana',
          'Ossey' => 'Oswald',
          'Eliphal' => 'Eliphalet',
          'Emmie' => 'Emily',
          'Otis' => 'Othello',
          'Eppa' => 'Aphrodite',
          'Char' => 'Charlotte',
          'Lynn' => 'Marilyn',
          'Seney' => 'Eseneth',
          'Vessey' => 'Sylvester',
          'Quilly' => 'Aquilla',
          'Franie' => 'Frances',
          'Lettie' => 'Violetta',
          'Amy' => 'Amelia',
          'Bob' => 'Robert',
          'Chuck' => 'Charles',
          'Fannnie' => 'Nathaniel',
          'Terry' => 'Therese',
          'Janey' => 'Jane',
          'Natius' => 'Ignatius',
          'Minty' => 'Armida',
          'Deanny' => 'Geraldine',
          'Rod' => 'Roderick',
          'Myrti' => 'Myrtle',
          'Tan' => 'Nathaniel',
          'Tracie' => 'Theresa',
          'Jap' => 'Jasper',
          'Indy' => 'India',
          'Florrie' => 'Florence',
          'Hester' => 'Esther',
          'Ollie' => 'Oliver',
          'Alyssa' => 'Melissa',
          'Ardy' => 'Ardeshir',
          'Chad' => 'Charles',
          'Michael' => 'Mitchell',
          'Jeffry' => 'Jefferson',
          'Nessey' => 'Agnes',
          'Fallie' => 'Eliphalet',
          'Bea' => 'Blanche',
          'Adaline' => 'Adelaide',
          'Perrie' => 'Pelegrine',
          'Manda' => 'Amanda',
          'Wood' => 'Woodrow',
          'Valeda' => 'Valentina',
          'Jakey' => 'Jacqueline',
          'Angelina' => 'Angela',
          'Russ' => 'Russell',
          'Tessy' => 'Theresa',
          'Beedy' => 'Obedience',
          'Josie' => 'Josephine',
          'Sinah' => 'Lucina'
);

1;
