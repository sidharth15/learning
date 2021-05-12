package com.example.demo.api;

import com.example.demo.model.Person;
import com.example.demo.service.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNull;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.UUID;

@RequestMapping("api/v1/person")
@RestController
public class PersonController {

    private final PersonService personService;

    @Autowired
    public PersonController(PersonService personService) {
        this.personService = personService;
    }

    @PostMapping
    public void addPerson(@Valid @NonNull @RequestBody Person person) {
        personService.addPerson(person);
    }

    @GetMapping
    public List<Person> getPersons() {
        return personService.getPersons();
    }

    @GetMapping(path = "{id}")
    public Person selectPersonById(@PathVariable("id") UUID id) {
        return personService.findPersonById(id)
                .orElse(null);
    }

    @DeleteMapping(path = "{id}")
    public int deletePerson(@PathVariable("id") UUID id) {
        return personService.deletePersonById(id);
    }

    @PutMapping(path = "{id}")
    public int updatePersonById(@PathVariable("id") UUID id,
                                @Valid @NonNull @RequestBody Person person) {
        return personService.updatePersonById(id, person);
    }
}