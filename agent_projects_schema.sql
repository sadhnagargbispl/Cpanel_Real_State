-- ═══════════════════════════════════════════════════════
--  agent_projects.aspx  —  Required DB Tables & Sample Data
-- ═══════════════════════════════════════════════════════

-- 1. Projects Table
CREATE TABLE Projects (
    ProjectID    INT IDENTITY(1,1) PRIMARY KEY,
    ProjectName  NVARCHAR(150)  NOT NULL,
    ProjectType  NVARCHAR(80)   NOT NULL,   -- Colony | Housing | Plots | Township | Commercial | Green
    Location     NVARCHAR(200)  NOT NULL,
    Status       NVARCHAR(30)   NOT NULL DEFAULT 'Active',  -- Active | Upcoming | Closed
    TotalPlots   INT            NOT NULL DEFAULT 0,
    CreatedAt    DATETIME       NOT NULL DEFAULT GETDATE()
);

-- 2. Plots Table (already exists — just confirming required columns)
-- CREATE TABLE Plots (
--     PlotID      INT IDENTITY(1,1) PRIMARY KEY,
--     ProjectID   INT NOT NULL REFERENCES Projects(ProjectID),
--     PlotNumber  NVARCHAR(50),
--     PlotSize    NVARCHAR(50),
--     Price       DECIMAL(18,2),
--     Status      NVARCHAR(30) DEFAULT 'Available'   -- Available | Booked | Sold | Reserved
-- );

-- 3. AgentProjects — which projects an agent can access
CREATE TABLE AgentProjects (
    AgentProjectID INT IDENTITY(1,1) PRIMARY KEY,
    AgentID        INT NOT NULL,   -- FK → your Agents/Users table
    ProjectID      INT NOT NULL REFERENCES Projects(ProjectID),
    AssignedDate   DATETIME NOT NULL DEFAULT GETDATE(),
    UNIQUE (AgentID, ProjectID)
);

-- 4. Project Access Requests — from the modal
CREATE TABLE ProjectAccessRequests (
    RequestID    INT IDENTITY(1,1) PRIMARY KEY,
    AgentID      INT           NOT NULL,
    ProjectName  NVARCHAR(150) NOT NULL,
    Note         NVARCHAR(500),
    RequestDate  DATETIME      NOT NULL DEFAULT GETDATE(),
    Status       NVARCHAR(30)  NOT NULL DEFAULT 'Pending'  -- Pending | Approved | Rejected
);

-- ═══════════════════════════════════════════════════════
--  Sample Data
-- ═══════════════════════════════════════════════════════

INSERT INTO Projects (ProjectName, ProjectType, Location, Status, TotalPlots) VALUES
('Sky Residencia Lahore',  'Colony',     'Raiwind Road, Lahore',    'Active',   1200),
('Sky Villas Islamabad',   'Housing',    'B-17, Islamabad',         'Upcoming',  480),
('Sky Gardens Faisalabad', 'Plots',      'Canal Road, Faisalabad',  'Active',    750),
('Nova Heights Rawalpindi','Township',   'GT Road, Rawalpindi',     'Active',   3400),
('Sky Commerce Centre',    'Commercial', 'MM Alam Rd, Lahore',      'Upcoming',  240),
('Green Valley Multan',    'Green',      'Bosan Road, Multan',      'Active',    900);

-- Assign all 6 projects to agent with AgentID = 1
INSERT INTO AgentProjects (AgentID, ProjectID) VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6);

-- Sample Available Plots (so AvailablePlots count shows correctly)
-- Add plots with Status='Available' in the Plots table as needed.
