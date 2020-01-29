CREATE TABLE [dbo].[emp] (
    [emp_id]   INT          NOT NULL,
    [emp_name] VARCHAR (20) NULL,
    [mgr_id]   INT          NULL,
    CONSTRAINT [pk_eid] PRIMARY KEY CLUSTERED ([emp_id] ASC),
    CONSTRAINT [fk_mgrid] FOREIGN KEY ([mgr_id]) REFERENCES [dbo].[emp] ([emp_id])
);

