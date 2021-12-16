CREATE TABLE employee
(
    employee_id       BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    employee_name     VARCHAR(255),
    email             VARCHAR(255),
    username          VARCHAR(255),
    password          VARCHAR(255),
    created_on        TIMESTAMP WITHOUT TIME ZONE             NOT NULL,
    created_by        VARCHAR(255),
    modified_on       TIMESTAMP WITHOUT TIME ZONE,
    modified_by       VARCHAR(255),
    assigned_projects BIGINT,
    CONSTRAINT pk_employee PRIMARY KEY (employee_id)
);

CREATE TABLE employee_roles
(
    employee_id BIGINT  NOT NULL,
    role_id     INTEGER NOT NULL,
    CONSTRAINT pk_employee_roles PRIMARY KEY (employee_id, role_id)
);

CREATE TABLE issue
(
    issue_id                  BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    issue_summary             VARCHAR(255)                            NOT NULL,
    issue_description         TEXT,
    identified_date           TIMESTAMP WITHOUT TIME ZONE,
    status                    VARCHAR(30),
    priority                  VARCHAR(30),
    target_resolution_date    TIMESTAMP WITHOUT TIME ZONE,
    progress                  TEXT,
    actual_resolution_date    TIMESTAMP WITHOUT TIME ZONE,
    resolution_summary        TEXT,
    created_on                TIMESTAMP WITHOUT TIME ZONE             NOT NULL,
    created_by                VARCHAR(255),
    modified_on               TIMESTAMP WITHOUT TIME ZONE,
    modified_by               VARCHAR(255),
    assigned_to_employee_id   BIGINT,
    identified_by_employee_id BIGINT,
    related_project_id        BIGINT,
    CONSTRAINT pk_issue PRIMARY KEY (issue_id)
);

CREATE TABLE project
(
    project_id      BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    project_name    VARCHAR(255)                            NOT NULL,
    start_date      TIMESTAMP WITHOUT TIME ZONE,
    target_end_date TIMESTAMP WITHOUT TIME ZONE,
    actual_end_date TIMESTAMP WITHOUT TIME ZONE,
    created_on      TIMESTAMP WITHOUT TIME ZONE             NOT NULL,
    created_by      VARCHAR(255),
    modified_on     TIMESTAMP WITHOUT TIME ZONE,
    modified_by     VARCHAR(255),
    CONSTRAINT pk_project PRIMARY KEY (project_id)
);

CREATE TABLE roles
(
    id   INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    name VARCHAR(20),
    CONSTRAINT pk_roles PRIMARY KEY (id)
);

CREATE INDEX idx_employee_name ON employee (employee_name);

CREATE INDEX idx_issue_summary ON issue (issue_summary);

CREATE INDEX idx_project_name ON project (project_name);

ALTER TABLE employee
    ADD CONSTRAINT FK_EMPLOYEE_ON_ASSIGNED_PROJECTS FOREIGN KEY (assigned_projects) REFERENCES project (project_id);

ALTER TABLE issue
    ADD CONSTRAINT FK_ISSUE_ON_ASSIGNED_TO_EMPLOYEE FOREIGN KEY (assigned_to_employee_id) REFERENCES employee (employee_id);

ALTER TABLE issue
    ADD CONSTRAINT FK_ISSUE_ON_IDENTIFIED_BY_EMPLOYEE FOREIGN KEY (identified_by_employee_id) REFERENCES employee (employee_id);

ALTER TABLE issue
    ADD CONSTRAINT FK_ISSUE_ON_RELATED_PROJECT FOREIGN KEY (related_project_id) REFERENCES project (project_id);

ALTER TABLE employee_roles
    ADD CONSTRAINT fk_emprol_on_employee FOREIGN KEY (employee_id) REFERENCES employee (employee_id);

ALTER TABLE employee_roles
    ADD CONSTRAINT fk_emprol_on_role FOREIGN KEY (role_id) REFERENCES roles (id);