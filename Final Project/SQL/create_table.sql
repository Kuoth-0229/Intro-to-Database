----------------------------------------------------------------
--USER
CREATE TABLE public.Users(
    UserID                      Serial,            
    UserName                    VARCHAR (32),
    Email                       VARCHAR (256),
    UserPassword                VARCHAR (32),
    UserType                    VARCHAR (16),

    primary key (UserID)
);
----------------------------------------------------------------
--Resourse
--ROOM
CREATE TABLE public.Room(
    RoomID                      Serial,            
    RoomName                    VARCHAR (32),
    RoomType                    VARCHAR (16),
    Location                    VARCHAR (16),
    Capacity                    INT,

    primary key (RoomID)
);
--Instrument
CREATE TABLE public.Instrument(
    InstrumentID                Serial,            
    InstrumentName              VARCHAR (32),
    Stock                       INT,
    primary key (InstrumentID)
);
----------------------------------------------------------------
--Booking
CREATE TABLE public.booking(
    bookingID                   Serial,
    UserID                      INT,
    RoomID                      INT,
    InstrumentID                INT,
    BookingDate                 date,
    StartDate                   date,
    EndDate                     date,
    Status                      INT,
    -- 0 wait for confirm
    -- 1 confirm
    -- -1 reject
    primary key (bookingID),
    foreign key (UserID) references Users(UserID),
    foreign key (RoomID) references Room(RoomID),
    foreign key (InstrumentID) references Instrument(InstrumentID)
);
----------------------------------------------------------------
--Violation
CREATE TABLE public.Violation(
    ViolationID                 Serial,
    ViolatorID                  INT,
    Reason                      VARCHAR(256),
    EndDate                     date,

    primary key (ViolationID),
    foreign key (ViolatorID) references Users(UserID)
);
----------------------------------------------------------------
--Feedback
CREATE TABLE public.Feedback(
    FeedbackID                  Serial,
    UserID                      INT,
    RoomID                      INT,
    InstrumentID                INT,
    RespondID                   INT,
    ViolatorID                  INT,
    Comment                     VARCHAR(256),
    FeedbackDate                date,

    primary key (FeedbackID),
    foreign key (UserID) references Users(UserID),
    foreign key (RoomID) references Room(RoomID),
    foreign key (InstrumentID) references Instrument(InstrumentID),
    foreign key (RespondID) references Feedback(FeedbackID)
);