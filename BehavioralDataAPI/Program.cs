using Microsoft.EntityFrameworkCore;
using BehavioralDataAPI.Models.Context;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
builder.Services.AddDbContext<UserContext>(opt =>
    opt.UseInMemoryDatabase("Users"));
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c => {
    c.ResolveConflictingActions(desc => desc.First());
    c.IgnoreObsoleteActions();
    c.IgnoreObsoleteProperties();
    c.CustomSchemaIds(type => type.FullName);
});

var app = builder.Build();

app.Use((context, next) =>
{
    context.Response.Headers["Access-Control-Allow-Origin"] = "*";
    context.Response.Headers["Access-Control-Allow-Methods"] = "POST, GET, PUT, OPTIONS";
    context.Response.Headers["Access-Control-Allow-Headers"] = "Origin, Content-Type, X-Auth-Token";
    if (context.Request.Headers.Any(k => k.Key.Contains("Origin")) && context.Request.Method == "OPTIONS")
    {
        context.Response.StatusCode = 200;
        return context.Response.WriteAsync("handled");
    }
    return next.Invoke();
});

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();

