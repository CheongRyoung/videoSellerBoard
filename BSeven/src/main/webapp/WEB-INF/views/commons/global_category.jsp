<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row mt-3" style="border-bottom: 1px solid #bdbdbd;" id="category">
              <div class="col p-0">
                <nav class="navbar navbar-expand-lg navbar-light bg-white">
                    <div class="container-fluid">
                      <a class="navbar-brand" href="../board/mainPage">Course</a>
                      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                      </button>
                      <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-5">
                          <li class="nav-item ms-5">
                            <a class="nav-link" onclick="refreshCardList(this)">JAVA</a>
                          </li>
                          <li class="nav-item ms-5">
                            <a class="nav-link" onclick="refreshCardList(this)">SQL</a>
                          </li>
                          <li class="nav-item ms-5">
                            <a class="nav-link" onclick="refreshCardList(this)">HTML</a>
                          </li>
                          <li class="nav-item ms-5">
                            <a class="nav-link" onclick="refreshCardList(this)">JAVASCRIPT</a>
                          </li>
                          <li class="nav-item ms-5">
                            <a class="nav-link" onclick="refreshCardList(this)">PYTHON</a>
                          </li>
                        </ul>
                        <form class="d-flex input-group ms-xl-5" onsubmit="return false">
                            <button type="button" class="input-group-text ms-5" onclick="searchProcess()"><i class="bi bi-search"></i></button>
                            <input id="searchinput" class="form-control me-2" type="search" placeholder="Search" aria-label="Search" onkeypress="if(event.keyCode==13){searchProcess()}">
                        </form>
                      </div>
                    </div>
                  </nav>
              </div>
            </div>