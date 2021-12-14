package com.kb.kiwibugback.issue;

import com.kb.kiwibugback.employee.Employee;
import com.kb.kiwibugback.employee.EmployeeRepository;
import com.kb.kiwibugback.project.Project;
import com.kb.kiwibugback.project.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@RestController
@RequestMapping("/api/issues")
public class IssueController {
    @Autowired
    IssueRepository issueRepository;

    @Autowired
    EmployeeRepository employeeRepository;

    @Autowired
    ProjectRepository projectRepository;

    @GetMapping
    @CrossOrigin(origins = "http://localhost:3000/")
    List<Issue> getIssues() {
        return issueRepository.findAll();
    }

    @PostMapping
    @CrossOrigin(origins = "http://localhost:3000/")
    Issue createIssue(@RequestBody Issue issue) {
        return issueRepository.save(issue);
    }

    @PutMapping("/{issueId}/employees/assign/{employeeId}")
    @CrossOrigin(origins = "http://localhost:3000/")
    Issue assignToEmployee(
            @PathVariable Long issueId,
            @PathVariable Long employeeId
    ) {
        Issue issue = issueRepository.findById(issueId).get();
        Employee employee = employeeRepository.findById(employeeId).get();
        issue.setAssignedToEmployeeId(employee);
        return issueRepository.save(issue);
    }

    @PutMapping("/{issueId}/employees/id/{employeeId}")
    @CrossOrigin(origins = "http://localhost:3000/")
    Issue identifiedByEmployee(
            @PathVariable Long issueId,
            @PathVariable Long employeeId
    ) {
        Issue issue = issueRepository.findById(issueId).get();
        Employee employee = employeeRepository.findById(employeeId).get();
        issue.setIdentifiedByEmployeeId(employee);
        return issueRepository.save(issue);
    }

    @PutMapping("/{issueId}/projects/{projectId}")
    @CrossOrigin(origins = "http://localhost:3000/")
    Issue assignProjectToIssue(
            @PathVariable Long issueId,
            @PathVariable Long projectId
    ) {
        Issue issue = issueRepository.findById(issueId).get();
        Project project = projectRepository.findById(projectId).get();
        issue.setProject(project);
        return issueRepository.save(issue);
    }
}
